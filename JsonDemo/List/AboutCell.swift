//
//  AboutCell.swift
//  JsonDemo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit
import SwiftTheme

class AboutCell: BaseCell {

    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.theme.font = "Global.textFont"
        content.theme.textColor = "Global.textColor"
    }

}
