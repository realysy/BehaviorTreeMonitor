cmake_minimum_required(VERSION 3.10)
project(BTMonitor)

message(STATUS "C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")

if (NOT MINGW AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    message("using asan")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -fno-omit-frame-pointer -fsanitize-recover=address")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address")
endif()

if (NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options("-O3")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive -fPIC -fexceptions -frtti -fsigned-char")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Bsymbolic")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pie -Bsymbolic")
if (CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wall -Werror=return-type)
endif()


set(ThirdLibs "")

find_package(Qt5 COMPONENTS Core Gui Widgets REQUIRED)
include_directories(${Qt5Core_INCLUDE_DIRS} ${Qt5Gui_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS})
list(APPEND ThirdLibs Qt5::Core Qt5::Gui Qt5::Widgets)
set(CMAKE_AUTOMOC ON)

include_directories(${PROJECT_SOURCE_DIR}/3rd)
include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${PROJECT_SOURCE_DIR}/client)

file(GLOB SrcFiles ${PROJECT_SOURCE_DIR}/src/*.cpp)
file(GLOB ClientFiles ${PROJECT_SOURCE_DIR}/client/*.cpp)

add_executable(BTMonitor 
    ${ClientFiles}
    ${SrcFiles}
)
target_link_libraries(BTMonitor ${ThirdLibs})

if(WIN32)
    target_link_options(BTMonitor PRIVATE "-mwindows")
endif()

