cmake_minimum_required(VERSION 2.8)
project(grpcore0) # C and CXX

include(./sdl2.cmake)

# Generate SDL path
set(sdl2path_orig ${CMAKE_CURRENT_LIST_DIR}/../SDL)
get_filename_component(sdl2path_abs ${sdl2path_orig} ABSOLUTE)
file(TO_CMAKE_PATH ${sdl2path_abs} sdl2path)

# Include path
include_directories(${sdl2path}/include)

# Platform dispatching
# See https://cmake.org/cmake/help/v3.5/manual/cmake-toolchains.7.html

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
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
    set_target_properties(grpcore0
        PROPERTIES
        LINK_FLAGS_RELEASE
        "/nodefaultlib:vccorlib /nodefaultlib:msvcrt vccorlib.lib msvcrt.lib"
        )
    set_target_properties(grpcore0
        PROPERTIES
        LINK_FLAGS_RELWITHDEBINFO
        "/nodefaultlib:vccorlib /nodefaultlib:msvcrt vccorlib.lib msvcrt.lib"
    )
    set_target_properties(grpcore0
        PROPERTIES
        LINK_FLAGS_DEBUG
        "/nodefaultlib:vccorlibd /nodefaultlib:msvcrtd vccorlibd.lib msvcrtd.lib"
        )
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "VCMDDAndroid")
    # Android (VisualStudio)
    # Instanciate SDL2 srcs
    set(sdl2srcs)
    foreach(e ${sdl2_common_srcs} ${sdl2_android_srcs}
            main/android/SDL_android_main.c)
        list(APPEND sdl2srcs ${sdl2path}/src/${e})
    endforeach()
    #set(sdl2asmsrcs
    #    ${sdl2path}/src/atomic/SDL_spinlock.c.arm)
    #set_source_files_properties(
    #    ${sdl2asmsrcs}
    #    PROPERTIES LANGUAGE C)
    
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
else()
    message(FATAL_ERROR "Unsupported for now")
endif()
