#encoding: utf-8
import os, sys, re
import json
from white_list_domain import make_white_domain_list

def make_trigger():    
    return {
        "url-filter": "hoge", 
        "unless-domain": make_white_domain_list("abp_jp.txt")
    }

def make_action():
    return {"selector": "fug", "type": "block"}

def make_element():
    dict = {"trigger" : make_trigger(), "action" : make_action()}

    return dict

def generate():
    white_domains = make_white_domain_list('abp_jp.txt')
    block_list = []
    block_list.append(make_element())

    generated_json = json.dumps(block_list, indent = 2)
    print(generated_json)

    block_json = open('generated_block_list.json', 'w+')
    block_json.write(generated_json)
    block_json.close()
    
if __name__ == '__main__':
    generate()