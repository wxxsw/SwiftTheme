//
//  ListViewController.swift
//  JsonDemo
//
//  Created by Gesen on 16/3/1.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.theme.backgroundColor = "Global.backgroundColor"
        tableView.theme.separatorColor = "ListViewController.separatorColor"
    }
    
}
