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
        let faviconUrl = extractFaviconUrl(from: attrs["content:encoded"])
        let article = HatebArticle(title: title,
                                   url: url,
                                   description: desc,
                                   categoryName: category,
                                   bookmarkCount: bookmarkCount,
                                   faviconUrl: faviconUrl)
        articles.append(article)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        self.completionHandler(articles)
    }
    
    private func extractFaviconUrl(from text: String?) -> URL? {
        guard let text = text else { return nil }
        /*
         <blockquote cite="http://www.smartstyle-blog.net/entry/CareerForProgrammer" title="今年39歳の私が、「プログラマー35歳定年説」について、考察してみる。 - 羊の夜をビールで洗う"><cite><img src="http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.smartstyle-blog.net%2Fentry%2FCareerForProgrammer" alt="" /> <a href="http://www.smartstyle-blog.net/entry/CareerForProgrammer">今年39歳の私が、「プログラマー35歳定年説」について、考察してみる。 - 羊の夜をビールで洗う</a></cite><p>2017 - 02 - 18 今年39歳の私が、「プログラマー35歳定年説」について、考察してみる。 しごと タイトルを書いてみて、「39」という数字の重みにいきなり、ずーん、となっている私です...。 ま、それはさておき、私が本業としているIT業界には、「プログラマー35歳定年説」というものがあります。 IT業界のお仕事には、現実世界のどの部分をソフトウェアで効率化するかを考える仕事（要件定義）...</p><p><a href="http://b.hatena.ne.jp/entry/http://www.smartstyle-blog.net/entry/CareerForProgrammer"><img src="http://b.hatena.ne.jp/entry/image/http://www.smartstyle-blog.net/entry/CareerForProgrammer" alt="はてなブックマーク - 今年39歳の私が、「プログラマー35歳定年説」について、考察してみる。 - 羊の夜をビールで洗う" title="はてなブックマーク - 今年39歳の私が、「プログラマー35歳定年説」について、考察してみる。 - 羊の夜をビールで洗う" border="0" style="border: none" /></a> <a href="http://b.hatena.ne.jp/append?http://www.smartstyle-blog.net/entry/CareerForProgrammer"><img src="http://b.hatena.ne.jp/images/append.gif" border="0" alt="はてなブックマークに追加" title="はてなブックマークに追加" /></a></p></blockquote>
        */
        
        guard let regex = try? NSRegularExpression(pattern: "<img\\ssrc=\"([^\">]+)\"[^>]+/>", options: []) else { return nil }
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
        guard let faviconUrlRange = matches.first?.rangeAt(1) else { return nil }
        let faviconUrl = (text as NSString).substring(with: faviconUrlRange)
        return URL(string: faviconUrl)
    }
}
