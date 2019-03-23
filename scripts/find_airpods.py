# -*- coding: utf-8 -*-
#!/usr/bin/env python

import subprocess
import re
import sys
import os

bluetooth_connector = subprocess.Popen(['/usr/local/bin/BluetoothConnector'], stdout=subprocess.PIPE).communicate()[0]

def get_airpod_info():
    ret = []
    regex = r"^([a-fA-F0-9-]{17}) - (.*)"
    matches = re.finditer(regex, bluetooth_connector, re.MULTILINE)
    for m in matches:
        if "airpods" in m.group(2).lower():
            airpod = { }
            airpod["name"] = m.group(2)
            airpod["mac"] = m.group(1).replace("-", ":").upper()
            ret.append(airpod)
    return ret


def find_name(mac):
    mac = mac.lower().replace(":", "-")
    regex = r"^([a-fA-F0-9-]{17}) - (.*)"
    matches = re.finditer(regex, bluetooth_connector, re.MULTILINE)
    for m in matches:
        if mac == m.group(1):
            return m.group(2)
    return None


def main():
    args = sys.argv
    airpod_info = get_airpod_info()
    if len(airpod_info) == 0:
        exit()
    airpod_name = airpod_info[0]["name"]
    airpod_mac = airpod_info[0]["mac"]
    if len(args) > 1:
        if args[1] == "--name" or args[1] == "-n":
            print(airpod_name)
            exit()
        elif args[1] == "--mac" or args[1] == "-m":
            print(airpod_mac)
            exit()
        elif args[1] == "--findname":
            try:
                search_mac = str(args[2])
                name = find_name(search_mac)
                if name is not None:
                    print(name)
                exit()
            except Exception as e:
                exit()
        else:
            pass
    print(airpod_name)
    print(airpod_mac)

if __name__ == '__main__':
    main()
