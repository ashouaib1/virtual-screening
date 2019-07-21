#! /bin/bash

### Edit the following variables as you see fit.

dataset='/userdata1/ashouaib/dataset.txt'

n_ligands=8486230
n_cores=400

### Everything below is the main body of the script.
### First we need to set up the virtual screening.

modulo=$((n_ligands%n_cores)) ## 230
increment=$(((n_ligands-modulo)/n_cores)) ## 21215

start_lig=1
end_lig=$increment

for((proc=1;proc<=$n_cores;proc++));do

    mkdir -p $proc
    cd $proc
    cp /userdata1/ashouaib/vina_files/virtual_screen.sh ./

    sed -n "${start_lig},${end_lig}p" $dataset > dataset.txt
    cd ../

    ((start_lig+=$increment))
    ((end_lig+=$increment))

done

sed -n "${start_lig},${end_lig}p" $dataset >> ./$n_cores/dataset.txt

for((proc=1;proc<=$n_cores;proc++));do

    cd $proc
### qsub virtual_screen.sh dataset.txt
    ./virtual_screen.sh dataset.txt >& log&
    cd ../

done
