cmake_minimum_required(VERSION 3.20)
project(8_BIT_CPU LANGUAGES C CXX ASM_NASM)

include_directories(${PROJECT_SOURCE_DIR}/src)

set(SOURCES
    src/main.asm
)

add_executable(8_BIT_CPU ${SOURCES})

set(CMAKE_ASM_NASM_FLAGS "-f elf64")
set_source_files_properties(src/main.asm PROPERTIES
    LANGUAGE ASM_NASM
)