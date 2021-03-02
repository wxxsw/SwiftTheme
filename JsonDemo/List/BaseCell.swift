//
//  BaseCell.swift
//  JsonDemo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
        self.theme.backgroundColor = "Global.backgroundColor"
    }

}
