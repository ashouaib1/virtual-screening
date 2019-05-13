#! /bin/bash

mkdir ./lig_files/
cp ./dump/*/*/*.gz ./lig_files
gunzip ./lig_files/*
cd ./lig_files/

for s in ./*.xaa.pdbqt; do
    csplit $s '/MODEL/' '{*}'
    for i in xx*; do
        zinc=$(cat $i | head -2 | tail -1 | tail -c 17)
        mv -- "$i" ./"${zinc}.pdbqt"
    done
done

rm *.xaa.pdbqt
