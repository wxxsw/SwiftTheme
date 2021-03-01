//
//  ChangeThemeCell.swift
//  Demo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class ChangeThemeCell: BaseCell {
    
    @IBOutlet weak var changeTheme: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        changeTheme.theme.setTitleColor(["#FFF", "#000", "#FFF", "#000"], forState: .normal)
        changeTheme.theme.setTitleColor(["#555", "#AAA", "#555", "#AAA"], forState: .highlighted)
        changeTheme.theme.backgroundColor = ["#EB4F38", "#F4C600", "#56ABE4", "#ECF0F1"]
        changeTheme.layer.cornerRadius = 60
    }
    
    @IBAction func tapChange(_ sender: UIButton) {
        MyThemes.switchToNext()
    }
    
    

}
