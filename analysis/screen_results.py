#! /usr/bin/env python

# this script is optional. If you're not comfortable with looking over all the data/results, use this.

import sys
import glob

result_path = '../screen/results/'

def screen(n):

    results = []

    for file_name in glob.glob(result_path + '*.pdbqt'):

	with open(file_name) as file:
	    lines = file.readlines()

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
