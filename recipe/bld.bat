
cmake %CMAKE_ARGS% ^
  -G "Ninja" ^
  -S %SRC_DIR% ^
  -B build ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_INSTALL_PREFIX="%PREFIX%" ^
  -D CMAKE_C_COMPILER=clang-cl ^
  -D CMAKE_C_FLAGS="/EHsc %CFLAGS%" ^
  -D CMAKE_CXX_COMPILER=clang-cl ^
  -D CMAKE_CXX_FLAGS="/EHsc %CXXFLAGS%" ^
  -D CMAKE_INSTALL_LIBDIR="Library\lib" ^
  -D CMAKE_INSTALL_INCLUDEDIR="Library\include" ^
  -D CMAKE_INSTALL_BINDIR="Library\bin" ^
  -D cerf_INSTALL_CMAKEDIR="Library\lib\cmake\cerf" ^
  -D BUILD_SHARED_LIBS=ON ^
  -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
  -D CERF_CPP=ON ^
  -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

cmake --build build ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

cd build
ctest --rerun-failed --output-on-failure
if errorlevel 1 exit 1

