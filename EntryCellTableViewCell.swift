//
//  EntryCellTableViewCell.swift
//  Concentrate
//
//  Created by 小宮山 司 on 2017/02/12.
//  Copyright © 2017年 Tsukasa K. All rights reserved.
//

import UIKit
import SDWebImage

class EntryCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bookmarkText: UILabel!
    @IBOutlet weak var domainText: UILabel!
    @IBOutlet weak var faviconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ entry: HatebArticle) {
        title.text = entry.title
        bookmarkText.text = "\(entry.bookmarkCount) Users"
        domainText.text = entry.url.host ?? ""
        faviconImage.sd_setImage(with: entry.faviconUrl)
        title.sizeToFit()

    }

}
