import argparse
import json
import re

def get_values(jsonfilepath, key): 
    with open(jsonfilepath, "r") as infile:
        json_content = json.load(infile)
    ind_key = re.split("/",key)
    value = json_content
    for i in ind_key:
     value = value.get(i) 
    print("key", "=", key) 
    print("value","=",value)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--jsonfile')
    parser.add_argument('--key')
    args = parser.parse_args()

    if args.jsonfile and args.key:
     get_values(args.jsonfile, args.key)
    else:
      print('Invalid Usage of the script')

if __name__ == "__main__":
    main()
