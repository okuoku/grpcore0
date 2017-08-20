
Building for UWP
================

 1) Configure with CMake comes with VS2017

```
 cmake -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0 \
 -G "Visual Studio 15 Win64" c:\path\to\here
```

Building for Android
====================

 1) Configure with

```
cmake.exe -G "Visual Studio 14 ARM" -DCMAKE_SYSTEM_NAME=VCMDDAndroid \
c:\path\to\here
```

 As of this writing, VCMDDAndroid is not merged to the official CMake project.
 See
  https://blogs.msdn.microsoft.com/vcblog/2015/12/15/support-for-android-cmake-projects-in-visual-studio/

Building for Emscripten
=======================

 1) Configure with

```
emconfigure cmake -G Ninja c:\path\to\here
emconfigure cmake -G Ninja c:\path\to\here
```

Currently we have to configure twice (to make CMakeCache settle).

