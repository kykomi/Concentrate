//
//  Category.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/11.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import Foundation

enum Category: String {
    /**
     rawValue represents rss file path
    **/
    
    case hotentry = "hotentry"
    case general = "general"
    case social = "social"
    case economics = "economics"
    case life = "life"
    case knowledge = "knowledge"
    case it = "it"
    case fun = "fun"
    case entertainment = "entertainment"
    case game = "game"
    
    func title() -> String {
        switch self {
        case .hotentry: return "総合"
        case .general: return "一般"
        case .social: return "世の中"
        case .economics: return "政治と経済"
        case .life: return "暮らし"
        case .knowledge: return "学び"
        case .it: return "テクノロジー"
        case .fun: return "おもしろ"
        case .entertainment: return "エンタメ"
        case .game: return "アニメとゲーム"
        }
    }
    
    static func values() -> [Category] {
        return [
            .hotentry,
            .general,
            .social,
            .economics,
            .life,
            .knowledge,
            .it,
            .fun,
            .entertainment,
            .game
        ]
    }
    
}
