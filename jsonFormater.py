
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
db = readFile("db_host.json")

file_path = 'inventory'
sys.stdout = open(file_path, "w")
print("[web-severs]")
print(ips[0])
print(ips[1])
print("[db-host]")
print(ips[1])

print(db)
# file_path = '/mnt/c/Perficient/RampUp/CI_CD/.env'
# sys.stdout = open(file_path, "w")
# print("DB_HOST="+file_path)
#echo $DB_HOST>>archivo.txt