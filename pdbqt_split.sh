#! /bin/bash

### The following script is used to parse and clean the downloaded dataset from the ZINC15 database.
### Run this script in the same directory as the 

chmod u+x ./ZINC
./ZINC
gunzip *.gz

mkdir change_names

for s in *.xaa.pdbqt; do
    check=$(head -c 6 $s)
    if [[ $check == "REMARK" ]]; then
        zinc_id=$(cat $s | head -1 | tail -c 17)
        mv $s /userdata1/ashouaib/dataset/"${zinc_id}.pdbqt"
    else
        vina_split --input $s --ligand ./change_names/
        cd ./change_names/
        for i in *.pdbqt; do
            zinc=$(cat $i | head -1 | tail -c 17)
            mv $i /userdata1/ashouaib/dataset/"${zinc}.pdbqt"
        done
        cd ../
    fi
done

rm -r change_names
rm -r *.pdbqt

echo "DOCKING FILE PROCESS COMPLETE"
