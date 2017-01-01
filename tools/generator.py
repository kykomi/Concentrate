#encoding: utf-8
import os, sys, re
import json

def make_trigger():
    return {"url-filter": "hoge"}

def make_action():
    return {"selector": "fug", "type": "block"}

def make_element():
    dict = {"trigger" : make_trigger(), "action" : make_action()}

    return dict

def generate():
    block_list = []
    block_list.append(make_element())

    print(json.dumps(block_list, indent = 2))
    

if __name__ == '__main__':
    generate()