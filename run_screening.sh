#! /bin/bash

### The following variables should be edited based on the project.

dataset='/userdata1/ashouaib/dataset.txt'

n_ligands=$((`wc -l $dataset | awk '{print $1}'`))
n_cores=12

### Below is the main body of the script.

modulo=$((n_ligands%n_cores))
increment=$(((n_ligands-modulo)/n_cores))

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
