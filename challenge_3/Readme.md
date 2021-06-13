# This can be done in 2 ways as shown below
## Method 1: Inline Input(Uses Python 2)
script_file_inline.py
This will prompt for _Object_ and _Key_ values.

**Usage**
```
python script_file_inline.py
$ Object = '<enter-json-object>'
$ key = '<enter-key>'
```

![image](https://user-images.githubusercontent.com/66135657/121817138-205f9980-cc9d-11eb-85bb-c6e0e8ee59c5.png)

-------
## Method 2: File Input(Uses Python 3)
script_file.py
This will take 2 arguments:
1) jsonfile = Path of the JSON file which needs to be parsed
2) key = This is the key for which the corresponding value has to be retrieved

**Usage**
```
python3 script_file.py --jsonfile <json-file-path> --key <key-value>
```

![image](https://user-images.githubusercontent.com/66135657/121817163-4b49ed80-cc9d-11eb-835d-fa30136e707d.png)
