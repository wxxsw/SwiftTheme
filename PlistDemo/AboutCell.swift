//
//  AboutCell.swift
//  PlistDemo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class AboutCell: BaseCell {

    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        content.theme.textColor = "Global.textColor"
    }

}
