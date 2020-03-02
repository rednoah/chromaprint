#!/bin/sh -xu


# reset
git reset --hard && git pull && git --no-pager log --pretty=oneline -1

# build
rm -rv "$PWD/dist" "CMakeCache.txt"
mkdir "$PWD/dist"
cmake -DCMAKE_INSTALL_PREFIX="$PWD/dist" -DCMAKE_BUILD_TYPE=Release -DBUILD_TOOLS=ON -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 -DCMAKE_OSX_ARCHITECTURES=x86_64 -DBUILD_TESTS=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DFFT_LIB=vdsp -DFFMPEG_ROOT="$PWD/package/ffmpeg-4.2.2-audio-macos-x86_64" .
make clean
make
make install

# test
"$PWD/dist/bin/fpcalc" -version
otool -l "$PWD/dist/bin/fpcalc"
otool -L "$PWD/dist/bin/fpcalc"
