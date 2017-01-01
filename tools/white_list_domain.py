#encoding: utf-8
import os, sys, re

def remove_adblock_syntax(v):
    tmp =  re.sub(r'^@@', '', v) # 否定の @@ を削除
    tmp2 = re.sub(r'\|\|', '', tmp) # 行頭の || で http, httpsを削除
    tmp3 = re.sub(r'(\^|\$).*', '', tmp2) # ホワイトリストのため ^, $, 以降のコンテンツタイプは表示は無視
    return tmp3.replace('*', '.*').replace('?', '\?').replace('|', '')

def make_white_domain_list(name):
    ptn = re.compile(r'^@@(.|\.|\/)*')
    f = open('./adblock/' + name)
    white_domains = []
    for l in f:        
        match = ptn.match(l)
        if match != None:
            domain = remove_adblock_syntax(match.group(0))
            white_domains.append(domain)
    f.close()
    return white_domains



if __name__ == '__main__':
    make_white_domain_list('abp_jp.txt')