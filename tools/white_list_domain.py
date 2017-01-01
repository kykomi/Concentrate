#encoding: utf-8
import os, sys, re

def remove_adblock_syntax(v):
    tmp =  re.sub(r'^@@', '', v) # 否定の @@ を削除
    tmp2 = re.sub(r'\|\|', '', tmp) # 行頭の || で http, httpsを削除
    return re.sub(r'(\^|\$).*', '', tmp2) # ホワイトリストのため ^, $, 以降のコンテンツタイプは表示は無視

def make(name):
    ptn = re.compile(r'^@@(.|\.|\/)*')
    f = open('../adblock/' + name)
    for l in f:        
        match = ptn.match(l)
        if match != None:
            
            print(remove_adblock_syntax(match.group(0)))
    
    f.close()

if __name__ == '__main__':
    make('abp_jp.txt')