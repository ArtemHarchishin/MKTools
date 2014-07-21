# coding=utf-8
import os
import sys
from xml.dom.minidom import parse

if len(sys.argv) < 2:
    print "[WARNING] Not enough arguments, set config name!"
    exit()

# <arg line="-connect  '176.37.74.97'" />

A = 'fast_compile_int_debug'
B = 'fast_compile_ru_debug'
C = 'not_fast_compile_int_debug'
D = 'not_fast_compile_ru_debug'

E = 'fast_compile_int_test'
F = 'fast_compile_ru_test'
G = 'not_fast_compile_int_test'
H = 'not_fast_compile_ru_test'

build_config = sys.argv[1]

debug_instrument_type = '-listen'
debug_instrument = debug_instrument_type + ' 7936'

try:

    # arg = sys.argv[2]
    arg = '-c'
    if arg == '-l':
        debug_instrument_type = '-listen'
        debug_instrument = debug_instrument_type + ' 7936'
    elif arg == '-c':
        debug_instrument_type = '-connect'
        debug_instrument = debug_instrument_type + ' 192.168.0.100'

except Exception, e:
    pass

if build_config not in {A, B, C, D, E, F, G, H}:
    print "[WARNING] No have config settings with name '" + build_config + "'"
    exit()

configs = {
    'file_path': {
        A: "MobileANT_iOS_int.xml",
        B: "MobileANT_iOS_ru.xml",
        C: "MobileANT_iOS_int.xml",
        D: "MobileANT_iOS_ru.xml",
        E: "MobileANT_iOS_int.xml",
        F: "MobileANT_iOS_ru.xml",
        G: "MobileANT_iOS_int.xml",
        H: "MobileANT_iOS_ru.xml"},
    'type': {
        A: "'ipa-debug-interpreter'",
        B: "'ipa-debug-interpreter'",
        C: "'ipa-debug'",
        D: "'ipa-debug'",
        E: "'ipa-test-interpreter'",
        F: "'ipa-test-interpreter'",
        G: "'ipa-test'",
        H: "'ipa-test'"},
}

print 'Selected config is \'' + build_config + "' and implement " + configs['type'][build_config]

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

need_add = True
get_next = False
next_arg = None
test_configs = {E, F, G, H}
can_out_from_cycle = False

with open(file_path, 'r') as f:
    dom = parse(f)
    for node in dom.getElementsByTagName('target'):
        if "package.apple" == node.getAttribute('name'):
            exec_node = node.getElementsByTagName('exec')[0]
            for arg in exec_node.getElementsByTagName('arg'):
                if get_next:
                    next_arg = arg
                    get_next = False
                    can_out_from_cycle = True

                attribute = arg.getAttribute('line')
                if attribute.find('-package -target') == 0:
                    get_next = True
                    arg.setAttribute('line', '-package -target ' + configs['type'][build_config])
                    print '[' + attribute + '] ===> [' + arg.getAttribute('line') + ']'

                if build_config in test_configs and (attribute.find('-listen') == 0 or attribute.find('-connect') == 0):
                    need_add = False
                    arg.setAttribute('line', '')
                    print 'For element <arg/> set attribute line=""'
                    if can_out_from_cycle:
                        break

                elif build_config not in test_configs and (attribute.find('-listen') == 0 or attribute.find('-connect') == 0 or attribute == ''):
                    need_add = False
                    arg.setAttribute('line', debug_instrument)
                    print 'For element <arg/> set attribute line="' + debug_instrument + '"'
                    if can_out_from_cycle:
                        break

if need_add:
    new_element = dom.createElement('arg')
    exec_node.insertBefore(new_element, next_arg)
    new_element.setAttribute('line', debug_instrument)
    print 'Added new element <arg/> with attribute line="' + debug_instrument + '"'

import codecs

with codecs.open(file_path, 'w', encoding='utf-8') as f_write:
    dom.writexml(f_write, "", "", "", "UTF-8")

print 'All well done!'