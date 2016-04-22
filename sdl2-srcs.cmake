set(sdl2_winrt_srcs
    audio/xaudio2/SDL_xaudio2_winrthelpers.cpp
    core/winrt/SDL_winrtapp_common.cpp
    core/winrt/SDL_winrtapp_direct3d.cpp
    core/winrt/SDL_winrtapp_xaml.cpp
    filesystem/winrt/SDL_sysfilesystem.cpp
    power/winrt/SDL_syspower.cpp
    render/direct3d11/SDL_render_winrt.cpp
    video/winrt/SDL_winrtevents.cpp
    video/winrt/SDL_winrtkeyboard.cpp
    video/winrt/SDL_winrtmessagebox.cpp
    video/winrt/SDL_winrtmouse.cpp
    video/winrt/SDL_winrtopengles.cpp
    video/winrt/SDL_winrtpointerinput.cpp
    video/winrt/SDL_winrtvideo.cpp
    )

set(sdl2_win32_common_srcs
    audio/xaudio2/SDL_xaudio2.c
    core/windows/SDL_windows.c
    core/windows/SDL_xinput.c
    haptic/windows/SDL_dinputhaptic.c
    haptic/windows/SDL_windowshaptic.c
    haptic/windows/SDL_xinputhaptic.c
    joystick/windows/SDL_dinputjoystick.c
    joystick/windows/SDL_windowsjoystick.c
    joystick/windows/SDL_xinputjoystick.c
    loadso/windows/SDL_sysloadso.c
    render/direct3d11/SDL_render_d3d11.c
    timer/windows/SDL_systimer.c
    )

set(sdl2_android_srcs
    audio/android/SDL_androidaudio.c
    # atomic/SDL_spinlock.c.arm # FIXME: generate this?
    core/android/SDL_android.c
    joystick/android/SDL_sysjoystick.c

    # FIXME: Not andorid specific..
    loadso/dlopen/SDL_sysloadso.c

    power/android/SDL_syspower.c
    filesystem/android/SDL_sysfilesystem.c

    # FIXME: Not andorid specific..
    render/opengles/SDL_render_gles.c

    # FIXME: Not andorid specific..
    thread/pthread/SDL_syscond.c
    thread/pthread/SDL_sysmutex.c
    thread/pthread/SDL_syssem.c
    thread/pthread/SDL_systhread.c
    thread/pthread/SDL_systls.c

    # FIXME: Not andorid specific..
    timer/unix/SDL_systimer.c

    video/android/SDL_androidclipboard.c
    video/android/SDL_androidevents.c
    video/android/SDL_androidgl.c
    video/android/SDL_androidkeyboard.c
    video/android/SDL_androidmessagebox.c
    video/android/SDL_androidmouse.c
    video/android/SDL_androidtouch.c
    video/android/SDL_androidvideo.c
    video/android/SDL_androidwindow.c
    )

set(sdl2_stdcpp_srcs
    # FIXME: OK?
    thread/generic/SDL_syssem.c

    thread/stdcpp/SDL_syscond.cpp
    thread/stdcpp/SDL_sysmutex.cpp
    thread/stdcpp/SDL_systhread.cpp
    )

set(sdl2_common_srcs
    atomic/SDL_atomic.c
    atomic/SDL_spinlock.c

    audio/disk/SDL_diskaudio.c
    audio/dummy/SDL_dummyaudio.c

    audio/SDL_audio.c
    audio/SDL_audiocvt.c
    audio/SDL_audiodev.c
    audio/SDL_audiotypecvt.c
    audio/SDL_mixer.c
    audio/SDL_wave.c

    cpuinfo/SDL_cpuinfo.c

    dynapi/SDL_dynapi.c

    events/SDL_clipboardevents.c
    events/SDL_dropevents.c
    events/SDL_events.c
    events/SDL_gesture.c
    events/SDL_keyboard.c
    events/SDL_mouse.c
    events/SDL_quit.c
    events/SDL_touch.c
    events/SDL_windowevents.c

    file/SDL_rwops.c

    haptic/dummy/SDL_syshaptic.c
    haptic/SDL_haptic.c

    joystick/dummy/SDL_sysjoystick.c
    joystick/SDL_gamecontroller.c
    joystick/SDL_joystick.c

    power/SDL_power.c

    render/opengles2/SDL_render_gles2.c
    render/opengles2/SDL_shaders_gles2.c
    render/SDL_d3dmath.c
    render/SDL_render.c
    render/SDL_yuv_mmx.c
    render/SDL_yuv_sw.c
    render/software/SDL_blendfillrect.c
    render/software/SDL_blendline.c
    render/software/SDL_blendpoint.c
    render/software/SDL_drawline.c
    render/software/SDL_drawpoint.c
    render/software/SDL_render_sw.c
    render/software/SDL_rotate.c

    SDL.c
    SDL_assert.c
    SDL_error.c
    SDL_hints.c
    SDL_log.c

    stdlib/SDL_getenv.c
    stdlib/SDL_iconv.c
    stdlib/SDL_malloc.c
    stdlib/SDL_qsort.c
    stdlib/SDL_stdlib.c
    stdlib/SDL_string.c

    thread/SDL_thread.c

    timer/SDL_timer.c

    video/dummy/SDL_nullevents.c
    video/dummy/SDL_nullframebuffer.c
    video/dummy/SDL_nullvideo.c
    video/SDL_blit.c
    video/SDL_blit_0.c
    video/SDL_blit_1.c
    video/SDL_blit_A.c
    video/SDL_blit_auto.c
    video/SDL_blit_copy.c
    video/SDL_blit_N.c
    video/SDL_blit_slow.c
    video/SDL_bmp.c
    video/SDL_clipboard.c
    video/SDL_egl.c
    video/SDL_fillrect.c
    video/SDL_pixels.c
    video/SDL_rect.c
    video/SDL_RLEaccel.c
    video/SDL_shape.c
    video/SDL_stretch.c
    video/SDL_surface.c
    video/SDL_video.c
    )
