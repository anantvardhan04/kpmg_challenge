# This can be done in 2 ways as shown below
## Inline Input(Uses Python 2)
script_file_inline.py
This will prompt for _Object_ and _Key_ values.

**Usage**
```
python script_file_inline.py
$ Object = '<enter-json-object>'
$ key = '<enter-key>'
```

-------
## File Input(Uses Python 3)
script_file.py
This will take 2 arguments:
1) jsonfile = Path of the JSON file which needs to be parsed
2) key = This is the key for which the corresponding value has to be retrieved

**Usage**
```
python3 script_file.py --jsonfile <json-file-path> --key <key-value>
```

Example:

python3 script_file.py --jsonfile ./test.json --key x/y/z

Output:

➜  python3 script_file.py --jsonfile ./test.json --key x/y/z
key = x/y/z
value = a
