#encoding: utf-8
import os, sys, re
import json
from white_list_domain import make_white_domain_list
from block_simple_domain import make_simple_domain_list

def make_trigger():
    return {
        "url-filter": ""
    }

def make_trigger_with_white_list():
    return {
        "url-filter": "", 
        "unless-domain": white_list_domains
    }

def make_action():
    return {"type": "block"}

def make_element():
    dict = {"trigger" : make_trigger(), "action" : make_action()}

    return dict

def make_block_simple_domain_element(url_filter):
    base_element = make_element()    
    trigger = make_trigger() if len(url_filter) >= 8 else make_trigger_with_white_list()
    trigger["url-filter"] = url_filter
    base_element["trigger"] = trigger
    return base_element

def generate_simple_json_file():
    block_simple_url_list = []    
    for filter_domain in make_simple_domain_list('abp_jp.txt'):
        block_simple_url_list.append(make_block_simple_domain_element(filter_domain))

    generated_json = json.dumps(block_simple_url_list, indent = 2)
    print(generated_json)

    block_json = open('generated_block_simple_list.json', 'w+')
    block_json.write(generated_json.lower())
    block_json.close()    

def generate():
    generate_simple_json_file()



global white_list_domains
if __name__ == '__main__':
    white_list_domains = make_white_domain_list("abp_jp.txt")  
    generate()