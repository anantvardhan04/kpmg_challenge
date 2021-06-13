import argparse
import json
import re
import ast

def get_values(jsonobject, key): 
    json_content = json.loads(jsonobject)
    value = json_content
    ind_key = re.split("/",key)
    for i in ind_key:
     value = value.get(i) 
    print("value = " + value)

def main():
    object = input("Object = ")
    key = input("key = ")
    
    get_values(object, key)
    
if __name__ == "__main__":
    main()
