//
//  UILabel+TextAttributes.swift
//  SwiftTheme
//
//  Created by Gesen on 2019/9/1.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit

extension UILabel {
    @objc func updateTextAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let text = self.attributedText else { return }
        
        self.attributedText = NSAttributedString(
            attributedString: text,
            merging: newAttributes
        )
    }
}
