#!/bin/sh
source $stdenv/setup
PATH=$dpkg/bin:$PATH

dpkg -x $src unpacked

cp -r unpacked/opt/$name $out/
cp -r unpacked/usr $out/
