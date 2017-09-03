# Toolchain file for SysGCC/raspberry

set(GRPCORE0_SYSGCC_RPI_ROOT "c:/SysGCC/Raspberry")
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER "${GRPCORE0_SYSGCC_RPI_ROOT}/bin/arm-linux-gnueabihf-gcc.exe")
set(CMAKE_CXX_COMPILER "${GRPCORE0_SYSGCC_RPI_ROOT}/bin/arm-linux-gnueabihf-g++.exe")

set(CMAKE_SYSROOT "${GRPCORE0_SYSGCC_RPI_ROOT}/arm-linux-gnueabihf/sysroot")
set(CMAKE_FIND_ROOT_PATH "${GRPCORE0_SYSGCC_RPI_ROOT}/arm-linux-gnueabihf/sysroot")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(GRPCORE0_RPI ON)

