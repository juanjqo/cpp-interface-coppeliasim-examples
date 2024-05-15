if(UNIX AND NOT APPLE)
    FIND_PACKAGE(Eigen3 REQUIRED)
    INCLUDE_DIRECTORIES(${EIGEN3_INCLUDE_DIR})
    ADD_COMPILE_OPTIONS(-Werror=return-type -Wall -Wextra -Wmissing-declarations -Wredundant-decls -Woverloaded-virtual)
endif()

if(APPLE) #APPLE
    INCLUDE_DIRECTORIES(
        /usr/local/include/
        /usr/local/include/eigen3
        # Most recent versions of brew install here
        /opt/homebrew/include
        /opt/homebrew/include/eigen3
    )
    ADD_COMPILE_OPTIONS(-Werror=return-type -Wall -Wextra -Wmissing-declarations -Wredundant-decls -Woverloaded-virtual)
    # The library is installed here when using the regular cmake ., make, sudo make install
    LINK_DIRECTORIES(
        /usr/local/lib/
        /opt/homebrew/lib/
        )
endif()



if(WIN32)
    include(C:/vcpkg/scripts/buildsystems/vcpkg.cmake)
    set(CMAKE_TOOLCHAIN_FILE C:/vcpkg/scripts/buildsystems/vcpkg.cmake)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
    ADD_DEFINITIONS(-D_USE_MATH_DEFINES)
    FIND_PACKAGE(Eigen3 CONFIG REQUIRED)
    INCLUDE_DIRECTORIES(${EIGEN3_INCLUDE_DIR})
    find_package(cppzmq CONFIG REQUIRED)

    set(DQROBOTICS_PATH "C:/Program Files (x86)/dqrobotics")
    add_library(dqrobotics SHARED IMPORTED)
    set_target_properties(dqrobotics PROPERTIES
        IMPORTED_LOCATION ${DQROBOTICS_PATH}/bin/dqrobotics.dll
        IMPORTED_IMPLIB   ${DQROBOTICS_PATH}/lib/dqrobotics.lib
        INTERFACE_INCLUDE_DIRECTORIES ${DQROBOTICS_PATH}/include)

    set(DQROBOTICS_COPPELIASIM_PATH "C:/Program Files (x86)/dqrobotics-interface-coppeliasim")
    add_library(dqrobotics-interface-coppeliasim SHARED IMPORTED)
    set_target_properties(dqrobotics-interface-coppeliasim PROPERTIES
        IMPORTED_LOCATION ${DQROBOTICS_COPPELIASIM_PATH}/bin/dqrobotics-interface-coppeliasim.dll
        IMPORTED_IMPLIB   ${DQROBOTICS_COPPELIASIM_PATH}/lib/dqrobotics-interface-coppeliasim.lib
        INTERFACE_INCLUDE_DIRECTORIES ${DQROBOTICS_COPPELIASIM_PATH}/include)
    target_link_libraries(dqrobotics-interface-coppeliasim INTERFACE cppzmq)
endif()
