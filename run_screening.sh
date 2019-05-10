#! /bin/bash

mkdir screen
mkdir screen/results
cd lig_files/

# We want the total number of ligands in our screening

nfile=$(eval "ls -1 | wc -l")
nfile_aggre=$((nfile/$1))

echo "processing $nfile ligands"

# Now we create directories based on the number of cores
# and aggregate all the ligand files into these directories
# Number of cores we are working with is the first argument ($1)

for((proc=1;proc<=$1;proc++)); do
    mkdir ../screen/$proc
    mv `ls | head -$nfile_aggre` ../screen/$proc/
done

mv * ../screen/$1/
cd ../

# Now we can run the screening in each directory

for((i=1;i<=$1;i++)); do
    cp ./vina_files/virtual_screen.sh ./screen/$i/
    cd ./screen/$i
    nohup ./virtual_screen.sh >& screen.log&
    cd ../../
done


