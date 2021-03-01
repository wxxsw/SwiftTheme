//
//  ChangeThemeCell.swift
//  PlistDemo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class ChangeThemeCell: BaseCell {
    
    @IBOutlet weak var changeTheme: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        changeTheme.theme.setTitleColor("ChangeThemeCell.buttonTitleColorNormal", forState: .normal)
        changeTheme.theme.setTitleColor("ChangeThemeCell.buttonTitleColorNormal", forState: .highlighted)
        changeTheme.theme.backgroundColor = "ChangeThemeCell.buttonBackgroundColor"
        changeTheme.layer.cornerRadius = changeTheme.bounds.size.width / 2
    }
    
    @IBAction func tapChange(_ sender: UIButton) {
        MyThemes.switchToNext()
    }

}
