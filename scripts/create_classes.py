import os, sys

chr=sys.argv[1]

out_file=open("../data/input/rfmix/chr" + chr + "/classes.txt", "w")
for i in range(0,766):
    out_file.write("0 0 ")
for i in range(0, 99):
    out_file.write("1 1 ")
for i in range(0, 108):
    out_file.write("2 2 ")
out_file.write("\n")
out_file.close()
