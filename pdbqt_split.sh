#! /bin/bash

mkdir ./lig_files/
cp ./downloads/*/*/*.gz ./lig_files
gunzip ./lig_files/*
cd ./lig_files/

for s in ./*.xaa.pdbqt; do
    csplit $s '/MODEL/' '{*}'
    for i in xx*; do
        check=$(head -c 6 $i)
        if [[ $check == "REMARK" ]]; then
            zinc_id=$(cat $i | head -1 | tail -c 17)
            mv -- "$i" ./"${zinc_id}.pdbqt"
        else
            zinc=$(cat $i | head -2 | tail -1 | tail -c 17)
            mv -- "$i" ./"${zinc}.pdbqt"
        fi
    done
done

rm *.xaa.pdbqt
