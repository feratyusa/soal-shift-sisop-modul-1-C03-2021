#!/bin/bash

pass=$(date +%d%m%Y)

zip -q -e -P $pass Koleksi.zip Kucing_*/* Kelinci_*/*

rm -r Kucing_*/ > /dev/null 2>&1
rm -r Kelinci_*/ > /dev/null 2>&1