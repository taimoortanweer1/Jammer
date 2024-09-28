# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appJammer_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appJammer_autogen.dir\\ParseCache.txt"
  "appJammer_autogen"
  )
endif()
