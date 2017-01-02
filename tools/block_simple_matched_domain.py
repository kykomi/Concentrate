#encoding: utf-8
import os, sys, re

def to_only_domain(v):
    tmp =  re.sub(r'^\|\|', '', v) # ドメインを表す || を削除
    tmp2 = re.sub(r'^\|https?:/{0,2}', '', tmp) # |http(s): を削除
    tmp3 = tmp2.replace('\n', '').replace('^', '[^0-9a-z_\-%]')
    tmp4 = tmp3.replace('*', '.*').replace('?', '\?').replace('|', '')
    return tmp4

def make_simple_domain_matched_list(name):
    # || →　全部一致
    # |　→ プロトコルから記載

    # あとで！！！
    # ^ が含まれているものが対象だが
    # $ が含まれているものは除外（ 種類の指定があるので）
    # それぞれドメインだけにする
    ptn = re.compile(r'^(\|\|.*\^+.*|\|.*\^+.*)')
    f = open('./adblock/' + name)
    domains = []
    for l in f:        
        match = ptn.match(l)
        if match != None:
            domain = to_only_domain(match.group(0))
            domains.append(domain)
    f.close()

    target_domains = []
    for domain in domains:
        if '$' in domain:
            pass
        else:
            target_domains.append(domain)

    # ads.example.com を
    # ^https?://[^/]*ads.example.com:?[0-9]*/ に編集してから入れる
    # adblock ^ はセパレータ（英数字、アンスコ、%,ドット以外）
    # see https://adblockplus.org/filter-cheatsheet#options
    simple_domains = []
    unique_domains = list(set(target_domains))
    for domain in unique_domains:
        simple_domains.append("^https?://[^/]*" + domain + "[^0-9a-z_\-%\.]")
    return simple_domains

if __name__ == '__main__':
    make_simple_domain_matched_list('abp_jp.txt')