//
//  ContentBlockerRequestHandler.swift
//  Blocking
//
//  Created by 小宮山 司 on 2017/01/01.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
     
        let attachment = NSItemProvider(contentsOf: Bundle.main.url(
            forResource: "merged",
            withExtension: "json"))!
       
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
