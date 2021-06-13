script.py will take 2 arguments:
1) jsonfile = Path of the JSON file which needs to be parsed
2) key = This is the key for which the corresponding value has to be retrieved

-----
Usage
-----

python3 script_file.py --jsonfile <json-file-path> --key <key-value>


Example:

python3 script_file.py --jsonfile ./test.json --key x/y/z

Output:

➜  python3 script_file.py --jsonfile ./test.json --key x/y/z
key = x/y/z
value = a