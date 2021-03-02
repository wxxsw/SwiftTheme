//
//  SwitchNightCell.swift
//  JsonDemo
//
//  Created by Gesen on 16/3/2.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit
import SwiftTheme

class SwitchNightCell: BaseCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nightIcon: UIImageView!
    @IBOutlet weak var nightSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()

        title.theme.textColor = "Global.textColor"
        nightIcon.theme.image = "SwitchNightCell.iconImage"
        
        updateNightSwitch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNightSwitch), name: NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }
    
    @IBAction func changeNight(_ sender: UISwitch) {
        MyThemes.switchNight(sender.isOn)
    }
    
    @objc fileprivate func updateNightSwitch() {
        nightSwitch.isOn = MyThemes.isNight()
    }

}
