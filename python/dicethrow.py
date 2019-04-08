#!/usr/bin/env python3

import argparse
import sys
import random

parser = argparse.ArgumentParser(description='Generate dice throws using RPG-like syntax')
parser.add_argument('command', metavar='<T>d<S>', help='simulate T throws with a S-sided die')

args = parser.parse_args()

list = args.command.split('d', 1)

try:
    throws = int(list[0])
except ValueError:
    print('T is not a number')
    sys.exit(1)

try:
    sides = int(list[1])
except ValueError:
    print('S is not a number')
    sys.exit(1)

random.seed()

for i in range(throws):
    print(random.randint(1, sides))
