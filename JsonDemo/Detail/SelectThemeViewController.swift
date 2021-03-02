//
//  SelectThemeViewController.swift
//  JsonDemo
//
//  Created by Gesen on 16/3/1.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

class SelectThemeViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.theme.backgroundColor = "Global.backgroundColor"
    }
    
    @IBAction func tapRed(_ sender: AnyObject) {
        MyThemes.switchTo(.red)
    }
    
    @IBAction func tapYellow(_ sender: AnyObject) {
        MyThemes.switchTo(.yello)
    }
    
    @IBAction func tapBlue(_ sender: AnyObject) {
        guard MyThemes.isBlueThemeExist() else {

            let title   = "Not Downloaded"
            let message = "Download the theme right now?"
            
            if #available(iOS 8.0, *) {
                
                let alert = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)

                alert.addAction(UIAlertAction(
                    title: "Cancel",
                    style: .cancel,
                    handler: nil)
                )
                alert.addAction(UIAlertAction(
                    title: "Sure",
                    style: .default,
                    handler: { [unowned self] _ in
                        self.downloadStart()
                    })
                )
                
                present(alert, animated: true, completion: nil)
                
            } else {
                
                UIAlertView(title: title,
                            message: message,
                            delegate: self,
                            cancelButtonTitle: "Cancel",
                            otherButtonTitles: "Sure").show()
                
            }
            return
        }
        
        MyThemes.switchTo(.blue)
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            downloadStart()
        }
    }
    
    fileprivate func downloadStart() {
        let HUD = navigationController!.showHUD("Download Theme...")
        
        MyThemes.downloadBlueTask() { isSuccess in
            HUD.label.text = isSuccess ? "Successful!" : "Failure!"
            HUD.mode = .text
            HUD.hide(animated: true, afterDelay: 1)
            
            if isSuccess {
                MyThemes.switchTo(.blue)
            }
        }
    }

}
