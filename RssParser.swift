//
//  RssParser.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/12.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import Foundation

class RssParser: NSObject, XMLParserDelegate {
    var key: String = ""
    var articles: [HatebArticle] = []
    var attrs: [String:String] = [:]
    let completionHandler: ([HatebArticle]) -> Void
    
    init(completionHandler: @escaping ([HatebArticle]) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func parse(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]) {
        key = elementName
        switch elementName {
        case "item":
            attrs.removeAll()
        default:
            break
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if key == "title" {
            print(string)
        }
        let editted = string.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        
        switch key {
        case "link", "hatena:bookmarkcount":
            attrs[key] = (attrs[key] ?? "") + editted.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        default:
            attrs[key] = (attrs[key] ?? "") + editted
        }
    }

    public func parser(_ parser: XMLParser,
                       didEndElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?) {
        if (elementName != "item") {
            return
        }
        
        guard let title = attrs["title"],
            let urlString = attrs["link"],
            let desc = attrs["description"],
            let category = attrs["dc:subject"],
            let bCount = attrs["hatena:bookmarkcount"]
            else { return }
        
        guard let url = URL(string: urlString) else { return }
        guard let bookmarkCount = Int(bCount) else { return }
        
        let article = HatebArticle(title: title, url: url, description: desc, categoryName: category, bookmarkCount: bookmarkCount)
        articles.append(article)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        self.completionHandler(articles)
    }
}
