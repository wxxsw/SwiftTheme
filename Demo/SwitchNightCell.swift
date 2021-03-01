//
//  SwitchNightCell.swift
//  Demo
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

        title.theme.textColor = GlobalPicker.textColor
        nightIcon.theme.image = ["icon_night_dark", "icon_night_dark", "icon_night_dark", "icon_night_light"]
        
        updateNightSwitch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNightSwitch), name: NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }
    
    @IBAction func changeNight(_ sender: UISwitch) {
        MyThemes.switchNight(isToNight: sender.isOn)
    }
    
    @objc private func updateNightSwitch() {
        nightSwitch.isOn = MyThemes.isNight()
    }

}
