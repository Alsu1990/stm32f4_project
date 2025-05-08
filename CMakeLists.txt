cmake_minimum_required(VERSION 3.15)

# Set project name and enable C and ASM languages
project(STM32F4Discovery LANGUAGES C ASM)

# Specify the target chip
set(TARGET_CHIP STM32F407VG)

# Add the path to the toolchain file
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/cmake/arm-gcc-toolchain.cmake)

# Set the C standard
set(CMAKE_C_STANDARD 11)


# Add the example_lib subdirectory
add_subdirectory(${CMAKE_SOURCE_DIR}/lib/example_lib)

# Add include directories
include_directories(${CMAKE_SOURCE_DIR}/app/include)

# Specify source files
file(GLOB_RECURSE PROJECT_SOURCES
    ${CMAKE_SOURCE_DIR}/app/src/*.c
)

# Specify the linker script
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/config/stm32f407vg.ld)

# Add executable
add_executable(${PROJECT_NAME}.elf
    ${PROJECT_SOURCES}
)

# Link the example_lib
target_link_libraries(${PROJECT_NAME}.elf
    # example_lib
)

# Linker options
target_link_options(${PROJECT_NAME}.elf PRIVATE
    -T${LINKER_SCRIPT}
    -Wl,--gc-sections
)
