cmake_minimum_required(VERSION 3.5)

project(proxqp_test LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../dependencies.cmake)
include_directories("C:/Program Files (x86)/dqrobotics-interface-proxqp/include")


add_executable(${CMAKE_PROJECT_NAME} main.cpp)

target_link_libraries(${CMAKE_PROJECT_NAME}
                      dqrobotics
                      dqrobotics-interface-coppeliasim)
