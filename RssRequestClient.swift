//
//  RssRequestClient.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/11.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import Foundation

class RssRequestClient {
    static let baseUrl = "http://b.hatena.ne.jp/"
    
    func request(_ category: Category, status: EntryStatus, completionHandler: @escaping ([HatebArticle])->Void)-> Void {
        
        func pathFor(_ category: Category, and status: EntryStatus) -> String {
            if category == .hotentry {
                return "hotentry.rss"
            } else {
                return status.rawValue + "/" + category.rawValue + ".rss"
            }
        }
        
        let rssUrlString = RssRequestClient.baseUrl + pathFor(category, and: status)
        let url = URL(string: rssUrlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                let parser = RssParser(completionHandler: completionHandler)
                parser.parse(data: data)
            }

        }).resume()
    }
}
