#! /bin/bash

receptor_file='/userdata1/ashouaib/vina_files/cyp_A.pdbqt'
config_file='/userdata1/ashouaib/vina_files/config.txt'

mkdir results

for f in $(cat $1); do
    b=`basename $f .pdbqt`
    /software/autodock_vina_1_1_2_linux_x86/bin/vina --config $config_file --receptor $receptor_file --cpu 1 --ligand /userdata1/ashouaib/dataset/$f --out results/${b}_vina.pdbqt --log results/${b}_vina.log
done

echo "SCREENING DONE"
