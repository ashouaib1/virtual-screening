#! /usr/bin/env python

import sys
import glob

# provide the path containing your results from the screening.

result_path = '../screen/results/'

# The below function will perform the screening.

def screen(n):

    results = []

    for file_name in glob.glob(result_path + '*.pdbqt'):

        file = open(file_name)
        lines = file.readlines()
        file.close()

        score = lines[1]
        result = float(score.split(':')[1].split()[0])

	zinc_id = lines[2]
	molecule = zinc_id.split('=')[1].strip()

        results.append([result, molecule, file_name])

    results.sort(lambda x,y: cmp(x[0], y[0]))
    top_list = results[:n]

    for i in top_list:
        print i[1], i[0], i[2]

if __name__ == '__main__':
    screen(int(sys.argv[1]))
