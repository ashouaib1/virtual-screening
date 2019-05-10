#! /bin/bash

mkdir ./lig_files/
gunzip ./dump/*/*/*.gz

for s in ./*/*/*/*.xaa.pdbqt; do
    check=$(head -c 6 $s)
    if [ $check == "REMARK" ]; then
        mv $s ./lig_files/
    else
        vina_split --input $s --ligand ./lig_files/lig
    fi
done

#rm ./lig_files/*.xaa.pdbqt
