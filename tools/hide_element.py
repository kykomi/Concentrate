#encoding: utf-8
import os, sys, re

def to_w3c_selector(adblock_selector):
    # AdBlcok -> tag -> W3c
    ###hoge -> id=hoge    -> #hoge
    ##.hoge -> class=hoge -> .hoge
    ##hoge = <hoge>       -> hoge
    tmp = adblock_selector.replace('##', '')

    return tmp

def make_hide_element_list(name):
    # コメント行、ホワイトリスト以外が対象
    ptn = re.compile(r'^[^!@\[\n].*')
    f = open('./adblock/' + name)
    target_lines = []
    for l in f:
        match = ptn.match(l)
        if match != None:
            target_lines.append(l)
    f.close()

    hide_items = []
    css_path_starting_with_selector_ptn = re.compile(r'^#.*')
    for l in target_lines:
        match = css_path_starting_with_selector_ptn.match(l)
        if match != None:             
            css_path = match.group(0)
            selector = to_w3c_selector(css_path)
            print(selector)
            hide_items.append(selector)
    return hide_items

def make_hide_element_list_with_url(name):
    # コメント行、ホワイトリスト以外が対象
    ptn = re.compile(r'^[0-9a-z].*')
    f = open('./adblock/' + name)
    target_lines = []
    for l in f:
        match = ptn.match(l)
        if match != None:
            target_lines.append(l)
    f.close()

    hide_items = []    
    for l in target_lines:
        domain_and_selector = l.split('#', 1)
        domain = domain_and_selector[0].replace('.', '\.')
        # 「#」で分割しているので1つたすと元の文字列
        selector = to_w3c_selector('#' + domain_and_selector[1]).replace('\n', '')
        hide_items.append((domain, selector))        
    return hide_items

if __name__ == '__main__':
    make_hide_element_list_with_url('abp_jp_element_hiding.txt')
    #make_hide_element_list('abp_jp_element_hiding.txt')