# coding=utf-8
import subprocess
import re

with open('stdOut.txt', 'w') as stdOut:
	subprocess.call(["C:\\air_sdk_and_compiler_13.0.0.111\\lib\\aot\\bin\\iOSBin\\idb.exe", "-devices"], stdout=stdOut)

with open('stdOut.txt', 'r') as stdOut:
	regex = re.compile(r' [0-9] ')
	match = re.search(r'.[0-9].', stdOut.read())
	deviceID = match.group(0)

subprocess.call(["C:\\air_sdk_and_compiler_13.0.0.111\\lib\\aot\\bin\\iOSBin\\idb.exe", "-forward", "7936", "7936", deviceID])
# C:\air_sdk_and_compiler_13.0.0.111\lib\aot\bin\iOSBin\idb.exe -forward 7936 7936 10

# subprocess.call(["C:\\air_sdk_and_compiler_13.0.0.111\\bin\\fdb.bat", "-p", "7936"], shell=True)
