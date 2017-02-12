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
    
    func request(category: Category, status: EntryStatus)-> Void {
        let rssUrlString = RssRequestClient.baseUrl + status.rawValue + "/" + category.rawValue + ".rss"
        let url = URL(string: rssUrlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                let parser = RssParser()
                parser.parse(data: data)
            }

        }).resume()
    }
}
