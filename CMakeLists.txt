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

include(./externals/sdl2-srcs.cmake)
include(./externals/angle-srcs.cmake)

# Generate SDL path
set(sdl2path_orig ${CMAKE_CURRENT_LIST_DIR}/externals/sdl)
get_filename_component(sdl2path_abs ${sdl2path_orig} ABSOLUTE)
file(TO_CMAKE_PATH ${sdl2path_abs} sdl2path)

# Include path
include_directories(${sdl2path}/include
    externals/nanovg/src)


if(${grpcore_platform} STREQUAL "win32")
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

    set(mysdlegl "patch_sdl/SDL_egl_grpcore0.c")
    include_directories(${sdl2path}/src/video)
    list(APPEND sdl2srcs ${mysdlegl})

    # Set toolchain options for SDL2 sources
    set_source_files_properties(${sdl2srcs} 
        PROPERTIES
        COMPILE_DEFINITIONS "_CRT_SECURE_NO_WARNINGS;_WINDOWS;HAVE_LIBC"
        )

    # ANGLE
    set(angle_srcs)
    use_static_angle(win32 angle_srcs)

    add_executable(grpcore0 WIN32
        ${sdl2srcs}
        ${angle_srcs}
        externals/nanovg/src/nanovg.c
        mysdlmain.c)

    target_link_libraries(grpcore0
        # Angle D3d9
        #d3d9
        # Angle D3d11
        dxguid
        winmm
        imm32
        version)
elseif(${grpcore_platform} STREQUAL "uwp")
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

    set(mysdlegl "patch_sdl/SDL_egl_grpcore0.c")
    include_directories(${sdl2path}/src/video)
    list(APPEND sdl2srcs ${mysdlegl})

    # ANGLE
    set(angle_srcs)
    use_static_angle(winrt angle_srcs)

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
        ${angle_srcs}
        externals/nanovg/src/nanovg.c
        mysdlmain.c)
    target_link_libraries(grpcore0
        dxguid)

    # Hey, it's 2017!
    # https://cmake.org/pipermail/cmake-developers/2014-November/023524.html
    # Release C++ runtime
    foreach(e RELEASE RELWITHDEBINFO)
        set_target_properties(grpcore0
            PROPERTIES
            LINK_FLAGS_${e}
            "/nodefaultlib:vccorlib /nodefaultlib:msvcrt vccorlib.lib msvcrt.lib"
            )
    endforeach()
    # Debug C++ runtime
    foreach(e DEBUG)
        set_target_properties(grpcore0
            PROPERTIES
            LINK_FLAGS_${e}
            "/nodefaultlib:vccorlib /nodefaultlib:msvcrtd vccorlib.lib msvcrtd.lib"
            )
    endforeach()
elseif(${grpcore_platform} STREQUAL "android")
    include(./cmake/GrpCore0Android.cmake)
    # Android
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_android_srcs}
            ${sdl2_egl_srcs}
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
        externals/nanovg/src/nanovg.c
        mysdlmain.c)

    target_link_libraries(grpcore0
        m
        dl
        EGL
        GLESv1_CM
        GLESv2
        log
        android)

    # Android packaging
    set(deploy_destdir
        ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android/src/main/libs/armeabi-v7a)
    add_custom_command(
        TARGET grpcore0 POST_BUILD
        COMMAND ${CMAKE_COMMAND}
        -DIN=$<TARGET_FILE:grpcore0> -DOUTDIR=${deploy_destdir}
        -P ${CMAKE_CURRENT_LIST_DIR}/cmake/deploy_file.cmake
        )
    add_gradle_command(apk ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android
        build)
    add_dependencies(apk grpcore0)
    add_gradle_command(apk_clean
        ${CMAKE_CURRENT_SOURCE_DIR}/pkg/android
        clean)
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
        externals/nanovg/src/nanovg.c
        mysdlmain.c)

    add_executable(grpcore0_html
        pkg/emscripten/emmain.c)
    target_link_libraries(grpcore0_html
        grpcore0)
    set_target_properties(grpcore0_html
        PROPERTIES
        SUFFIX ".html")
else()
    message(FATAL_ERROR "Unknown platform: ${grpcore_platform}")
endif()

