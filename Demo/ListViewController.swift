//
//  ListViewController.swift
//  Demo
//
//  Created by Gesen on 16/3/1.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.theme.backgroundColor = GlobalPicker.backgroundColor
        tableView.theme.separatorColor = ["#C6C5C5", "#C6C5C5", "#C6C5C5", "#ECF0F1"]
        
        updateTheme()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }
        
        updateTheme()
    }
    
    private func updateTheme() {
        guard #available(iOS 12.0, *) else { return }
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            MyThemes.switchNight(isToNight: false)
        case .dark:
            MyThemes.switchNight(isToNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
}
