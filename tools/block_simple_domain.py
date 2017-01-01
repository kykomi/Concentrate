#encoding: utf-8
import os, sys, re

def to_only_domain(v):
    tmp =  re.sub(r'^\|\|', '', v) # 否定の || を削除
    tmp2 = re.sub(r'^\|https?:/{0,2}', '', tmp) # |http(s): を削除
    tmp3 = tmp2.replace('*', '.*').replace('?', '\?').replace('|', '')
    return tmp3

def make_simple_domain_list(name):
    # || →　全部一致
    # |　→ プロトコルから記載
    # それぞれドメインだけにする
    ptn = re.compile(r'^(\|\|.*$|\|.*)')
    f = open('./adblock/' + name)
    domains = []
    for l in f:        
        match = ptn.match(l)
        if match != None:
            domain = to_only_domain(match.group(0))            
            domains.append(domain)
    f.close()

    # 末尾の独自ルール付きは無視。別で対応 (^や$でパターン指定)
    # 含まれていないものを対象
    simple_domains = []
    removing_ptn = re.compile(r'(\^|\$)')
    for domain in domains:
        match = removing_ptn.search(domain)
        if match == None:        
            simple_domains.append(domain)

    return simple_domains

if __name__ == '__main__':
    make_simple_domain_list('abp_jp.txt')