# coding=utf-8
import os
import sys

if len(sys.argv) < 2:
    print "[WARNING] Not enough arguments, set config name!"
    exit()

build_config = sys.argv[1] 

A = 'fast_compile_int'
B = 'fast_compile_ru'
C = 'not_fast_compile_int'
D = 'not_fast_compile_ru'

if build_config not in {A, B, C, D}:
    print "[WARNING] No have config settings with name '" + build_config + "'"
    exit()

print 'Selected config is \'' + build_config + "'"

configs = {
	'file_path': {
		A: "MobileANT_iOS_int.xml",  
		B: "MobileANT_iOS_ru.xml",  
		C: "MobileANT_iOS_int.xml",  
		D: "MobileANT_iOS_ru.xml"},
	'type': {
		A: "'ipa-test-interpreter'",  
		B: "'ipa-test-interpreter'",  
		C: "'ipa-app-store'",  
		D: "'ipa-app-store'"},
	'contr_type': {
		A: "'ipa-app-store'",  
		B: "'ipa-app-store'",  
		C: "'ipa-test-interpreter'",  
		D: "'ipa-test-interpreter'"},
	}

working_path = "D:\\Projects\\zombieranch\\front_end_mobile"
program_path = "D:\\Projects\\zombieranch\\front_end_mobile\\src\\MKTools"

if not os.path.exists(working_path):
    print "[ERROR] Incorrect working path '" + working_path + "'"
    exit()

os.chdir(working_path)
file_path = configs['file_path'][build_config]

if not os.path.exists(file_path):
    print "[ERROR] Incorrect working file '" + working_path + "'"
    exit()

print 'Selected file is \'' + file_path + "'"

if os.stat(file_path).st_size == 0:
    print "[ERROR] File '" + file_path + "' is empty!"
    exit()

s = ''
with open(file_path, 'r') as f:
  s = f.read().replace(configs['contr_type'][build_config], configs['type'][build_config])

with open(file_path, 'w') as f:
  f.write(s)

print 'All well done!'