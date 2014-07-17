# coding=utf-8
import os
from xml.dom.minidom import parse
import sys

if len(sys.argv) < 2:
    print "[WARNING] Not enough arguments, set config name!"
    exit()

build_config = sys.argv[1] 

A = 'desktop_ru'
B = 'ru_ios'
C = 'int_ios'
D = 'ru_ios_non_emulate'
E = 'int_ios_non_emulate'
F = 'desktop_int'

if build_config not in {A, B, C, D, E, F}:
    print "[WARNING] No have config settings with name '" + build_config + "'"
    exit()

print 'Selected config is \'' + build_config + "'"

working_path = "D:\\Projects\\zombieranch\\front_end_mobile"
program_path = "D:\\Projects\\zombieranch\\front_end_mobile\\src\\MKTools"
if not os.path.exists(working_path):
    print "[ERROR] Incorrect working path '" + working_path + "'"
    exit()

os.chdir(working_path)
file_path = "buildOneSWF.xml"

if not os.path.exists(file_path):
    print "[ERROR] Incorrect working file '" + working_path + "'"
    exit()

print 'Selected file is \'' + file_path + "'"

if os.stat(file_path).st_size == 0:
    print "[ERROR] File '" + file_path + "' is empty!"
    exit()

configs = {'config.debug':              {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'},
           'prop.debug':                {A: 'true',  B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'true'},
           'config.mobile':             {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'},
           'config.web':                {A: 'false', B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'false'},
           'config.android':            {A: 'true',  B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'true'},
           'config.ios':                {A: 'false', B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'false'},
           'config.emulator':           {A: 'true',  B: 'true',   C: 'true',   D: 'false',  E: 'false', F: 'true'},
           'config.profilerTest':       {A: 'false', B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'false'},
           'config.int':                {A: 'false', B: 'false',  C: 'true',   D: 'false',  E: 'true',  F: 'true'},
           'config.ru':                 {A: 'true',  B: 'true',   C: 'false',  D: 'true',   E: 'false', F: 'false'},
           'config.optimization':       {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'},
           'config.useQuests':          {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'},
           'config.log':                {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'},
           'config.release':            {A: 'false', B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'false'},
           'config.soc_version_dev':    {A: 'false', B: 'false',  C: 'false',  D: 'false',  E: 'false', F: 'false'},
           'config.soc_version_prod':   {A: 'true',  B: 'true',   C: 'true',   D: 'true',   E: 'true',  F: 'true'}}

import pickle

with open(file_path, 'r') as f_read:
    path_pickle = os.path.join(program_path, file_path + '.pickle')

    if not os.path.exists(path_pickle):
        with open(path_pickle, 'w') as f:
            pickle_data = ''
    else:
        with open(path_pickle, 'r') as f:
            pickle_data = pickle.load(f) 

    with open(path_pickle, 'w') as f:
        pickle.dump(build_config, f)

    print '[old] - ' + pickle_data, ':', build_config + ' - [new]'
    if pickle_data == build_config:
        print "[ATTENTION] The file was not changed!"
        f_read.close()
        exit()

    f_read.seek(0)
    dom = parse(f_read)
    for node in dom.getElementsByTagName('target'):
        if "setup debug" == node.getAttribute('name'):
            print 'Set properties for <target name="setup debug"> in ...'
            for prop in node.getElementsByTagName('property'):
                name = prop.getAttribute('name')
                prop.setAttribute('value', configs[name][build_config])
                print ' ', name, '=', prop.getAttribute('value')

import codecs

with codecs.open(file_path, 'w', encoding='utf-8') as f_write:
    dom.writexml(f_write, "", "", "", "UTF-8")

print 'All well done!'
