# Test Runner

> To use the script just copy the .sh file into the same directory as your project, also make sure that all your test cases are in a single folder

This script runs the test cases in the input folder and store them in a coresponding output folder
The program automatically detects the extension of the program and runs it accordingly:
Running: command program test_file *args > output
-    .py:    python3
-    .java:  java
-    .c:     gcc
-    .cpp:   g++
-    .js:    node
-    .sh:    bash

Usage: `./test.sh <flags> <program> <test_cases_folder>`

### Flags:
-    -h, --help:    Display this help message
-    -o, --output:  Specify the output folder
-    -a, --args:    Specify the arguments to be passed to the program
-    -e, -error:    This will create a file to track standard error stream.

### Args:
Arguments are passed to the file in ther order they are given after the -a flag
-   Key word arguments: If you want any keyword arguments type it in the form key=value
-   File as argument: if you want ether the input or output file as an argument us %if for input file and %of for output file. NOTE: if nether of these are used normal piping will be used.
  
>eg. `-a %if %of` --> command program folder/input_file fodler.out/output_file  
>eg. `-a` ----------> command program < folder/input_file > folder.out/output_file   

### Example:
-    `./test.sh -o output -a 1 2 3 test.py input`
-    `python3 test.py input/test1.txt 1 2 3 > output/test1.txt`


**NOTE**: This scipt only works with python at the moment. The other program types my have bugs, and will be fully implemented at a later date. (I will prioritise them on request)
