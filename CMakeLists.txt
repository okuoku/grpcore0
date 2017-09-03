cmake_minimum_required(VERSION 2.8.6)

# Platform dispatching
# See https://cmake.org/cmake/help/v3.5/manual/cmake-toolchains.7.html

set(grpcore_platform)

message(STATUS "Toolchain = [${CMAKE_TOOLCHAIN_FILE}]")
if(CMAKE_TOOLCHAIN_FILE)
    # FIXME: Why? Perhaps we have to consider platform BEFORE project()
    message(STATUS "Reloading toolchain file...")
    include(${CMAKE_TOOLCHAIN_FILE})
endif()
message(STATUS "System = [${CMAKE_SYSTEM_NAME}]")

message(STATUS "Emscripten = ${EMSCRIPTEN}")

if(EMSCRIPTEN)
    set(grpcore_platform "emscripten")
    set(GRPCORE_LOCAL_CONFIG ON)
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
    if(ANDROID_ABI)
        # Prefer Android first -- it seems we have WIN32 here...
        set(grpcore_platform "android")
        set(GRPCORE_SKIP_PACKAGING ON)
    elseif(CYGWIN OR UNIX)
        set(grpcore_platform "posix")
        set(GRPCORE_LOCAL_CONFIG ON)
    elseif(WIN32)
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
include(./externals/cimgui-srcs.cmake)

# Generate SDL path
set(sdl2path_orig ${CMAKE_CURRENT_LIST_DIR}/externals/sdl)
get_filename_component(sdl2path_abs ${sdl2path_orig} ABSOLUTE)
file(TO_CMAKE_PATH ${sdl2path_abs} sdl2path)

# Patch SDL not to use DynAPI
configure_file(patch_sdl/SDL_dynapi.h
    ${sdl2path}/src/dynapi/SDL_dynapi.h
    COPYONLY)

# Generate cimgui path
set(cimguipath_orig ${CMAKE_CURRENT_LIST_DIR}/externals/cimgui)
get_filename_component(cimguipath_abs ${cimguipath_orig} ABSOLUTE)
file(TO_CMAKE_PATH ${cimguipath_abs} cimguipath)
set(cimguisrcs)
foreach(e ${cimgui_srcs})
    list(APPEND cimguisrcs ${cimguipath}/${e})
endforeach()

set(common_srcs
    externals/nanovg/src/nanovg.c
    externals/imgui_impl_sdl/imgui_impl_sdl.cpp
    imgui_wrapper.cpp
    ${cimguisrcs})

include_directories(
    ${cimguipath}/imgui
    ${cimguipath}/cimgui
    externals/nanovg/src)

add_definitions(-DCIMGUI_NO_EXPORT)

# Include path
if(NOT GRPCORE_LOCAL_CONFIG)
    include_directories(${sdl2path}/include)
endif()


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

    if(MSVC)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
    endif()

    add_executable(grpcore0 WIN32
        ${sdl2srcs}
        ${angle_srcs}
        ${common_srcs}
        mysdlmain.c)

    target_link_libraries(grpcore0
        # Angle D3d9
        #d3d9
        # Angle D3d11
        dxguid
        winmm
        imm32
        version)
elseif(${grpcore_platform} STREQUAL "posix") # FIXME: X11
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e 
            ${sdl2_common_srcs} 
            ${sdl2_libm_srcs}
            ${sdl2_posix_srcs}
            ${sdl2_x11_srcs}
            )
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()
    set(mysdlegl "patch_sdl/SDL_egl_grpcore0.c")

    # Don't use Win32 backends on Cygwin
    add_definitions(
        -DUSING_GENERATED_CONFIG_H
        -DHAVE_LIBC
        -DSDL_TIMER_UNIX
        -DHAVE_NANOSLEEP
        -DHAVE_CLOCK_GETTIME
        -DSDL_THREAD_PTHREAD
        # Obvious.
        -DSDL_VIDEO_DRIVER_X11_SUPPORTS_GENERIC_EVENTS
        )
    include_directories(
        ${CMAKE_CURRENT_LIST_DIR}/include_sdl/posix
        ${sdl2path}/include
        ${sdl2path}/src/video
        )

    add_executable(grpcore0
        ${sdl2srcs}
        ${mysdlegl}
        ${common_srcs}
        mysdlmain.c)
    target_link_libraries(grpcore0
        X11
        Xext
        iconv
        EGL
        GLESv2)
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

    if(MSVC)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
    endif()

    add_definitions(
        -DIMGUI_DISABLE_WIN32_DEFAULT_CLIPBOARD_FUNCS
        -DIMGUI_DISABLE_WIN32_DEFAULT_IME_FUNCS)

    add_executable(grpcore0 WIN32
        ${sdl2srcs}
        ${angle_srcs}
        ${common_srcs}
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
            ${sdl2_egl_srcs} ${sdl2_posix_srcs}
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

    if(NOT GRPCORE_SKIP_PACKAGING)
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
    endif()
elseif(${grpcore_platform} STREQUAL "emscripten")
    # Emscripten
    message(STATUS "Generating for emscripten runtime")
    include_directories(
        BEFORE # Override SDL_config.h
        ${CMAKE_CURRENT_LIST_DIR}/include_sdl/emscripten)
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_emscripten_srcs} ${sdl2_egl_srcs})
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

