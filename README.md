# Test Runner

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

### Example:
-    `./test.sh -o output -a 1 2 3 test.py input`
-    `python3 test.py input/test1.txt 1 2 3 > output/test1.txt`