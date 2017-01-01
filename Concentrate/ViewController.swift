//
//  ViewController.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/01/01.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SFContentBlockerManager.reloadContentBlocker(
            withIdentifier: "com.kykomi.Concentrate.Blocking",
            completionHandler: { e in
                guard let e = e else { return }
                print(e)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
