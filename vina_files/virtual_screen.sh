#! /bin/bash
# mkdir results

for f in *.pdbqt; do
    b=`basename $f .pdbqt`
    /software/autodock_vina_1_1_2_linux_x86/bin/vina --config ../../vina_files/config.txt --receptor ../../vina_files/receptor.pdbqt --ligand $f --out ../results/${b}_results.pdbqt --log ../results/log_${b}.log
done
