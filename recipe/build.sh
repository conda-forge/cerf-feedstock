
cmake ${CMAKE_ARGS} \
  -S ${SRC_DIR} \
  -B build \
  -G "Ninja" \
  -D CMAKE_INSTALL_PREFIX=${PREFIX}

cmake --build build --target install -j$CPU_COUNT

cd build
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest --rerun-failed --output-on-failure -j${CPU_COUNT}
fi
