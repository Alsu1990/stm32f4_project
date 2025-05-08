# Minimum version of CMake required
cmake_minimum_required(VERSION 3.15)

# Define the library target
add_library(example_lib STATIC
    example.c
)

# Add include directories for the library
target_include_directories(example_lib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
