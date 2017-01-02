#encoding: utf-8
import os, sys, re

def make_hide_element_list(name):
    # コメント行、ホワイトリスト以外が対象
    ptn = re.compile(r'^[^!@\[\n].*')
    f = open('./adblock/' + name)
    target_lines = []
    for l in f:        
        match = ptn.match(l)
        if match != None:
            target_lines.append(l)
            print(l)
    f.close()

    # 末尾の独自ルール付きは無視。別で対応 (^や$でパターン指定)
    # 含まれていないものを対象
    hide_items = []
  
    return hide_items

if __name__ == '__main__':
    make_hide_element_list('abp_jp_element_hiding.txt')