#!/usr/bin/env bash

BUILD_DIR=./dist/trilium-linux-x64
rm -rf $BUILD_DIR

echo "Copying required linux-x64 binaries"

rm -r node_modules/sqlite3/lib/binding/*
rm -r node_modules/pngquant-bin/vendor/*

cp -r bin/deps/linux-x64/sqlite/* node_modules/sqlite3/lib/binding/
cp bin/deps/linux-x64/image/pngquant node_modules/pngquant-bin/vendor/

# rebuild binaries for image operations (pngquant ...)
npm rebuild

./node_modules/.bin/electron-packager . --asar --out=dist --executable-name=trilium --platform=linux --arch=x64 --overwrite

mv "./dist/Trilium Notes-linux-x64" $BUILD_DIR

cp images/app-icons/png/128x128.png $BUILD_DIR/icon.png

# removing software WebGL binaries because they are pretty huge and not necessary
rm -r $BUILD_DIR/swiftshader

echo "Packaging linux x64 electron distribution..."
VERSION=`jq -r ".version" package.json`

cd dist

tar cJf trilium-linux-x64-${VERSION}.tar.xz trilium-linux-x64
