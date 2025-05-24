cmake_minimum_required(VERSION 3.15)

# Set project name and enable C and ASM languages
project(STM32F4Discovery LANGUAGES C ASM)

# Specify the target chip
set(TARGET_CHIP STM32F411VET6)

# Add the path to the toolchain file
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/cmake/arm-gcc-toolchain.cmake)

# Set the C standard
set(CMAKE_C_STANDARD 11)

set(COMMON_COMPILER_FLAGS
    -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
    -g -O0 -Wall -Wextra -std=c11
    -ffunction-sections -fdata-sections -fno-common
)
add_compile_options(${COMMON_COMPILER_FLAGS})

add_compile_definitions(
    __ARM_ARCH_7EM__
    __VFP_FP__
    __FPU_PRESENT=1U
    ARM_MATH_CM4
    STM32F411VET6
    HSE_VALUE=(uint32_t)122000000UL
    HSI_VALUE=(uint32_t)16000000UL
    LSE_VALUE=(uint32_t)32768UL
    LSI_VALUE=(uint32_t)32000UL
)
# Add include directories
include_directories(${CMAKE_SOURCE_DIR}/app/include)

set(CMSIS_PATH ${CMAKE_SOURCE_DIR}/lib/CMSIS_6/CMSIS)
include_directories(
    ${CMSIS_PATH}/Core/Include
    ${CMSIS_PATH}/Core/Include/m-profile
)

# Specify source files
file(GLOB_RECURSE PROJECT_SOURCES
    ${CMAKE_SOURCE_DIR}/app/src/*.c
)

# Specify the linker script
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/config/stm32f407vg.ld)

# Add executable
add_executable(
    ${PROJECT_NAME}.elf
    ${PROJECT_SOURCES}
)

# Link the example_lib
target_link_libraries(${PROJECT_NAME}.elf)

# Linker options
target_link_options(
    ${PROJECT_NAME}.elf PRIVATE
    -T${LINKER_SCRIPT}
    -Wl,--gc-sections
)

# Create .bin (binary) and .hex (Intel HEX) files
add_custom_command(
    TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}.elf> ${PROJECT_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${PROJECT_NAME}.hex
    COMMENT "Generating .bin and .hex files"
)

# Add a size command for build output
add_custom_command(
    TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}.elf>
    COMMENT "Displaying size information"
)
