#!/bin/sh -xu


# reset
git reset --hard
git pull
git --no-pager log --pretty=oneline -1

# build
export export MACOSX_DEPLOYMENT_TARGET="10.10"
mkdir "$PWD/dist"
cmake -DCMAKE_INSTALL_PREFIX="$PWD/dist" -DCMAKE_BUILD_TYPE=Release -DBUILD_TOOLS=ON -DBUILD_SHARED_LIBS=OFF -DFFT_LIB=vdsp .
make clean
make
make install

# test
"$PWD/dist/bin/fpcalc" -version
otool -L "$PWD/dist/bin/fpcalc"
