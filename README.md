
Building for UWP
================

 1) Configure with

```
 cmake -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0.10586.0 \
 -G "Visual Studio 14 Win64" c:\path\to\here
```

 2) Edit ProjectPriFullPath as

```
<ProjectPriFullPath>$(ProjectDir)resources.pri</ProjectPriFullPath>
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

The build file won't generate application. To generate a working HTML app:

```
emcc -o check.html c:/path/to/here/emmain.c -L. -lgrpcore0
```

