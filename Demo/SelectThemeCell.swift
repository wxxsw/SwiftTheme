//
//  SelectThemeCell.swift
//  Demo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class SelectThemeCell: BaseCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var themeIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.theme.textColor = GlobalPicker.textColor
        themeIcon.theme.image = ["icon_theme.red", "icon_theme.yellow", "icon_theme.blue", "icon_theme.light"]
    }

}
