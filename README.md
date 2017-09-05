
Building for UWP
================

 1) Configure with CMake comes with VS2017

```
 cmake -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0 \
 -G "Visual Studio 15 Win64" c:\path\to\here
```

Building for Android
====================

 1) Open pkg/android directory with Android Studio

Building for Emscripten
=======================

 1) Configure with

```
emconfigure cmake -G Ninja c:\path\to\here
```

Building for RaspberryPi
========================

 1) Configigure with CMake, say `-DGRPCORE0_RPI=1`

- Grpcore will use statically-linked OpenGLES stack from broadcom
- `cmake/toolchain` includes toolchain file for SysGCC to support development on Windows

Building for Linux/Cygwin (X11)
===============================

 1) Install development packages

```
apt install libgles2-mesa-dev # On Linux(Ubuntu)
```

 2) Configure with CMake
