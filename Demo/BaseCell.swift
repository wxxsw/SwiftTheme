//
//  BaseCell.swift
//  Demo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        theme.backgroundColor = GlobalPicker.backgroundColor
    }

}
