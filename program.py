"""
Takes a file as an argument and prints the contents of the file to stdout,
it also prints a message to stderr indicating the file is being processed.
"""
import sys
import os

def main():
    file = sys.argv[1]
    
    if not os.path.isfile(file):
        print(f'Error: {file} does not exist.', file=sys.stderr)
        sys.exit(1)
        
    print(f'Processing {file}...', file=sys.stdout)
    
    with open(file, 'r') as f:
        for line in f.readlines():
            print(line.strip().lower(), file=sys.stdout)    
    
    print('Done.', file=sys.stderr)

if __name__ == '__main__':  
    main()