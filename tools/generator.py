#encoding: utf-8
import os, sys, re
import json
from white_list_domain import make_white_domain_list,make_element_white_domain_list
from block_simple_domain import make_simple_domain_list
from block_simple_matched_domain import make_simple_domain_matched_list
from hide_element import make_hide_element_list, make_hide_element_list_with_url

def make_trigger():
    return {
        "url-filter": ""
    }

def make_trigger_with_white_list():
    return {
        "url-filter": "", 
        "unless-domain": white_list_domains
    }

def make_hide_trigger(domain):
    if (domain == '.*'):        
        return {
            "url-filter": domain,
            "unless-domain": white_element_hide_domains_list
        }
    else:
        return { "url-filter" : domain}

def make_block_action():
    return {"type": "block"}

def make_hide_action(selector):
    return {"type": "css-display-none", "selector" : selector}

def make_element():
    dict = {"trigger" : make_trigger(), "action" : make_block_action()}
    return dict

def make_block_simple_domain_element(url_filter):
    base_element = make_element()    
    trigger = make_trigger() if len(url_filter) >= 8 else make_trigger_with_white_list()
    trigger["url-filter"] = url_filter
    base_element["trigger"] = trigger
    return base_element

def make_hide_element(domain, selector):
    base_element = make_element()
    trigger = make_hide_trigger(domain)
    base_element["trigger"] = trigger
    base_element["action"] = make_hide_action(selector)
    return base_element

def generate_simple_json_file():
    block_simple_url_list = []    
    for filter_domain in make_simple_domain_list('abp_jp.txt'):
        block_simple_url_list.append(make_block_simple_domain_element(filter_domain))

    generated_json = json.dumps(block_simple_url_list, indent = 2)
    print(generated_json)

    block_json = open('block_simple_list.json', 'w+')
    block_json.write(generated_json.lower())
    block_json.close()    

def generate_simple_matched_json_file():
    block_simple_url_list = []    
    for filter_domain in make_simple_domain_matched_list('abp_jp.txt'):
        block_simple_url_list.append(make_block_simple_domain_element(filter_domain))

    generated_json = json.dumps(block_simple_url_list, indent = 2)
    print(generated_json)

    block_json = open('block_simple_matched_list.json', 'w+')
    block_json.write(generated_json.lower())
    block_json.close()

def generate_element_hide_json_file():
    file_name = 'abp_jp_element_hiding.txt'
    hide_list = []
    # ドメインがワイルドカード    
    for hide_selector in make_hide_element_list(file_name):
        # 第一引数はドメイン　あとで
        hide_list.append(make_hide_element('.*', hide_selector))

    # ドメイン指定
    for domain_and_selector in make_hide_element_list_with_url(file_name):
        hide_list.append(make_hide_element(domain_and_selector[0], domain_and_selector[1]))

    generated_json = json.dumps(hide_list, indent = 2)

    element_hide_json = open('element_hide.json', 'w+')
    element_hide_json.write(generated_json.lower())
    element_hide_json.close()

def generate():
    generate_simple_json_file()
    generate_simple_matched_json_file()
    generate_element_hide_json_file()


global white_list_domains
global white_element_hide_domains_list
if __name__ == '__main__':
    white_list_domains = make_white_domain_list("abp_jp.txt")
    white_element_hide_domains_list = make_element_white_domain_list("abp_jp_element_hiding.txt")
    generate()