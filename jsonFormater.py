
import sys
import os
def readFile(fileName):
        fileObj = open(fileName, "r") #opens the file in read mode
        words = fileObj.read().split(",") #puts the file into an array
        fileObj.close()
        new_list = [s.replace("\"", "") for s in words]
        new_list = [s.replace("]", "") for s in new_list]
        new_list = [s.replace("\n", "") for s in new_list]
        new_list = [s.replace("[", "") for s in new_list]
        return new_list

ips = readFile("ips.json")

file_path = 'inventory'
sys.stdout = open(file_path, "w")
print("[web_severs]")
print(ips[0])
print(ips[1])
print("[db_host]")
print(ips[1])