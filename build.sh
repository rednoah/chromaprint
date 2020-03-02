#!/bin/sh -xu


# reset
git reset --hard
git pull
git --no-pager log --pretty=oneline -1

# build
mkdir "$PWD/dist"
cmake -DCMAKE_INSTALL_PREFIX="$PWD/dist" -DCMAKE_BUILD_TYPE=Release -DBUILD_TOOLS=ON -DBUILD_SHARED_LIBS=OFF -DFFT_LIB=vdsp .
make
make install

# test
"$PWD/dist/bin/fpcalc" -version
