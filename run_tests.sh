#!/bin/bash

# This script runs the test cases in the input folder and store them in a coresponding output folder
# 
# Usage: ./test.sh <input_folder> <output_folder>
# Example: ./test.sh input output
#
# It runs the files through a python scipt with name obstacleChess.py
# The output is stored in the output folder with the same name as the input file
# NOTE: This program does not work with files that have spaces in the name

help_message=$(cat <<EOF
Test Runner:\n
============\n
\n
This script runs the test cases in the input folder and store them in a coresponding output folder\n
The program automatically detects the extension of the program and runs it accordingly:\n
Running: command program test_file *args > output\n
\t    .py:    python3\n
\t    .java:  java\n
\t    .c:     gcc\n
\t    .cpp:   g++\n
\t    .js:    node\n
\t    .sh:    bash\n
\n
Usage: ./test.sh <flags> <program> <test_cases_folder>\n
\n
Flags:\n
\t    -h, --help:    Display this help message\n
\t    -o, --output:  Specify the output folder\n
\t    -a, --args:    Specify the arguments to be passed to the program\n
\n
Example:\n
\t    ./test.sh -o output -a 1 2 3 test.py input\n
\t    python3 test.py input/test1.txt 1 2 3 > output/test1.txt\n
EOF
)

args=()

if [ $# -lt 2 ]
then
    echo -e $help_message
    exit 1
fi

while [ $# -gt 2 ]; do
    case "$1" in
        -h|--help)
            echo -e $help_message
            exit 0
            ;;
        -o|--output)
            output_folder="$2"
            shift
            ;;
        -a|--args)
            while [[ $2 != -* && $# -gt 3 ]]; do
                args+=("$2")
                shift
            done
            shift
            ;;
        *)
            shift
            ;;
    esac
done

program=$1
test_cases_folder=$2

if [ $# -ne 2 ]
then
    echo "Usage: ./test.sh <program> <test_cases_folder>"
    exit 1
fi

if [ -d $test_cases_folder ]
then
    echo "Running test cases in $test_cases_folder/ ..."
else
    echo "Test cases folder ($test_cases_folder/) does not exist"
    exit 1
fi

if [ -z $output_folder ]
then
    output_folder=$test_cases_folder.out
fi

if [ -d $output_folder ]
then
    echo ""
    echo "Output folder ($output_folder) already exists"
    echo "Would you like to continue with this folder? (y/n)"
    read answer

    if [ ${answer^} = "y" ]
    then
        echo "Continuing with $output_folder ... "
    else
        echo "Output folder exists"
        echo "Creating a new output folder"

        norm_last_char=${output_folder: -1}
        last_dir=$(printf "%s\n" $output_folder* | sort -Vr | head -1)
        last_char=${last_dir: -1}

        if [ $last_char = $norm_last_char ]
        then
            new_folder=$output_folder"1"
        else
            new_folder=$output_folder$((last_char+1))
        fi

        output_folder=$new_folder
        mkdir $output_folder
    fi
else
    mkdir $output_folder
fi

program_ext=$(echo $program | cut -f 2 -d '.')
test_files=$(ls ./$test_cases_folder/)
line="========================================="

case $program_ext in
    "py")
        for file in $test_files; do
            test_file=$test_cases_folder/$file

            name=$(echo $file | cut -f 1 -d '.')
            extension=$(echo $file | cut -f 2 -d '.')
            output_file=$output_folder/$name.out.$extension

            echo $line
            echo "Running $test_file ..."
            echo "python3 $program $test_file ${args[@]} > $output_file"
            python3 $program $test_file ${args[@]} > $output_file
        done
        ;;
    "java")
        for file in test_files; do
            echo "Running $file ..."
            java $program $file ${args[@]} > $output_folder/$(basename $file)
        done
        ;;
    "c")
        for file in test_files; do
            echo "Running $file ..."
            gcc $program -o $program.out
            ./$program.out $file ${args[@]} > $output_folder/$(basename $file)
        done
        ;;
    "cpp")
        for file in test_files; do
            echo "Running $file ..."
            g++ $program -o $program.out
            ./$program.out $file ${args[@]} > $output_folder/$(basename $file)
        done
        ;;
    "js")
        for file in test_files; do
            echo "Running $file ..."
            node $program $file ${args[@]} > $output_folder/$(basename $file)
        done
        ;;
    "sh")
        for file in test_files; do
            echo "Running $file ..."
            bash $program $file ${args[@]} > $output_folder/$(basename $file)
        done
        ;;
    *)
        echo "Invalid program extension"
        exit 1
        ;;
esac
