set(LEGION_NAME legion)

if (CMAKE_BUILD_TYPE MATCHES Debug)
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DPRIVILEGE_CHECKS -DDEBUG_REALM -DDEBUG_LEGION -DBOUNDS_CHECKS -ggdb")
endif()

message(STATUS "Building ${LEGION_NAME}")
ExternalProject_Add(${LEGION_NAME}
 DEPENDS ${GASNET_NAME}
 SOURCE_DIR ${PROJECT_SOURCE_DIR}/legion
 PATCH_COMMAND patch -p1 < ${PROJECT_SOURCE_DIR}/patches/250.patch
 CONFIGURE_COMMAND ${CMAKE_COMMAND}
   -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
   -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DCMAKE_SHARED_LINKER_FLAGS:STRING=${CMAKE_SHARED_LINKER_FLAGS}
   -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
   -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
   -DGASNet_CONDUIT:STRING=${GASNet_CONDUIT}
   ${Legion_GASNet_OPTS}
   -DLegion_USE_GASNet=ON
   -DLegion_BUILD_EXAMPLES=ON
   <SOURCE_DIR>
)
