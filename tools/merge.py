#encoding: utf-8
import os, sys, re,glob
import json


def merge():
    jsons = glob.glob('*.json')
    list_of_list = []
    for json_file in jsons:
        json_contents = open(json_file).read()
        list_of_list.append(json.loads(json_contents))        
    dest = []
    for l in list_of_list:
        dest.extend(l)
    
    generated_json = json.dumps(dest, indent = 2)
    print(generated_json)

    merged = open('merged.json', 'w+')
    merged.write(generated_json.lower())
    merged.close()


if __name__ == '__main__':
    merge()
    