
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

