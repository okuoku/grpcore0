cmake_minimum_required(VERSION 2.8)

# Platform dispatching
# See https://cmake.org/cmake/help/v3.5/manual/cmake-toolchains.7.html

set(grpcore_platform)

message(STATUS "Toolchain = [${CMAKE_TOOLCHAIN_FILE}]")
message(STATUS "System = [${CMAKE_SYSTEM_NAME}]")

message(STATUS "Emscripten = ${EMSCRIPTEN}")

if(EMSCRIPTEN)
    set(grpcore_platform "emscripten")
endif()

# VisualStudio
if(CMAKE_SYSTEM_NAME)
    if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
        set(grpcore_platform "uwp")
    elseif(${CMAKE_SYSTEM_NAME} STREQUAL "VCMDDAndroid")
        set(grpcore_platform "android")
    endif()
endif()

# 2nd chance
if(NOT grpcore_platform)
    if(WIN32)
        set(grpcore_platform "win32")
    endif()
endif()

if(grpcore_platform)
    project(grpcore0-${grpcore_platform}) # C and CXX
else()
    message(FATAL_ERROR "Unsupported for now")
endif()

include(./sdl2.cmake)

# Generate SDL path
set(sdl2path_orig ${CMAKE_CURRENT_LIST_DIR}/../SDL)
get_filename_component(sdl2path_abs ${sdl2path_orig} ABSOLUTE)
file(TO_CMAKE_PATH ${sdl2path_abs} sdl2path)

# Include path
include_directories(${sdl2path}/include)


if(${grpcore_platform} STREQUAL "uwp")
    # WinRT(UWP)

    # WinRT main
    set(sdl2winrtmain
        ${sdl2path}/src/main/winrt/SDL_winrt_main_NonXAML.cpp)
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_win32_common_srcs}
            ${sdl2_stdcpp_srcs}
            ${sdl2_winrt_srcs})
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()
    list(APPEND sdl2srcs ${sdl2winrtmain})

    set(sdl2winrt)
    foreach(e ${sdl2_winrt_srcs})
        list(APPEND sdl2winrt ${sdl2path}/src/${e})
    endforeach()
    list(APPEND sdl2winrt ${sdl2winrtmain})

    # Set toolchain options for SDL2 sources
    set_source_files_properties(${sdl2srcs}
        PROPERTIES
        COMPILE_DEFINITIONS "_CRT_SECURE_NO_WARNINGS;SDL_BUILDING_WINRT=1"
        )

    # sdl2winrt: Assign /ZW 
    set_source_files_properties(${sdl2winrt}
        COMPILE_FLAGS "/ZW")

    add_executable(grpcore0 WIN32
        ${sdl2srcs}
        mysdlmain.c)

    # Hey, it's 2016!
    # https://cmake.org/pipermail/cmake-developers/2014-November/023524.html
    foreach(e RELEASE RELWITHDEBINFO DEBUG)
        set_target_properties(grpcore0
            PROPERTIES
            LINK_FLAGS_${e}
            "/nodefaultlib:vccorlib /nodefaultlib:msvcrt vccorlib.lib msvcrt.lib"
            )
    endforeach()
elseif(${grpcore_platform} STREQUAL "android")
    include(./cmake/GrpCore0Android.cmake)
    # Android
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_android_srcs}
            main/android/SDL_android_main.c)
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()

    # Set toolchain options for SDL2 sources
    set_source_files_properties(${sdl2srcs}
        PROPERTIES
        COMPILE_DEFINITIONS "GL_GLEXT_PROTOTYPES"
        )

    add_library(grpcore0 SHARED
        ${sdl2srcs}
        mysdlmain.c)

    target_link_libraries(grpcore0
        m
        dl
        GLESv1_CM
        GLESv2
        log
        android)

    # Android packaging
    set(deploy_dest
        ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android/src/main/libs/armeabi-v7a/libgrpcore0.so)
    add_custom_command(
        OUTPUT ${deploy_dest}
        COMMAND ${CMAKE_COMMAND}
        -DIN=$<TARGET_FILE:grpcore0> -DOUT=${deploy_dest}
        -P ${CMAKE_CURRENT_LIST_DIR}/cmake/deploy_file.cmake
        )
    add_custom_target(grpcore0_deploy
        DEPENDS ${deploy_dest})
    add_dependencies(grpcore0_deploy grpcore0)
    add_gradle_command(apk ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android
        build)
    add_dependencies(apk grpcore0_deploy)
    add_gradle_command(apk_clean
        ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android
        clean)
elseif(${grpcore_platform} STREQUAL "win32")
    # Win32 native

    # Win32 main
    set(sdl2win32main
        ${sdl2path}/src/main/windows/SDL_windows_main.c)
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_win32_common_srcs}
            ${sdl2_libm_srcs}
            ${sdl2_win32_desktop_srcs})
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()
    list(APPEND sdl2srcs ${sdl2win32main})

    # Set toolchain options for SDL2 sources
    set_source_files_properties(${sdl2srcs}
        PROPERTIES
        COMPILE_DEFINITIONS "_CRT_SECURE_NO_WARNINGS;_WINDOWS"
        )

    add_executable(grpcore0 WIN32
        ${sdl2srcs}
        mysdlmain.c)

    target_link_libraries(grpcore0
        winmm
        imm32
        version)
elseif(${grpcore_platform} STREQUAL "emscripten")
    # Emscripten
    message(STATUS "Generating for emscripten runtime")
    include_directories(
        BEFORE # Override SDL_config.h
        ${CMAKE_CURRENT_LIST_DIR}/include_sdl/emscripten)
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_emscripten_srcs})
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()

    add_library(grpcore0 STATIC
        ${sdl2srcs}
        mysdlmain.c)

endif()

