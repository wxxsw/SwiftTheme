//
//  CALayer+setFigmaShadowTokens.swift
//
//
//  Created by Paul Addy on 2/12/22.
//

import UIKit
#if os(iOS)
//ref: https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur
extension CALayer {
    func setFigmaShadowTokens(value: Any?) {
        guard let figmaValues = value as? [String: Any] else {
            fatalError("Could not cast figmaTokenValuesRaw to Dictionary")
        }

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var blur: CGFloat = 0
        var spread: CGFloat = 0
        var color: UIColor = .black
        var opacity: Float = 0

        for (key, value) in figmaValues {
            switch key {
            case "x":
                xOffset = value as! CGFloat
            case "y":
                yOffset = value as! CGFloat
            case "blur":
                blur = value as! CGFloat
            case "spread":
                spread = value as! CGFloat
            case "color":
                color = getColor(hexadecimal: value)
                opacity = getOpacity(hexadecimal: value)
            case "type":
                guard let type = value as? String,
                      type == "dropShadow" else {
                    assertionFailure("missingData")
                    return
                }
            default:
                assertionFailure("missingData")
            }
        }

        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = CGSize(width: xOffset, height: yOffset)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func getColor(hexadecimal: Any?) -> UIColor {
        guard let hex = hexadecimal as? String,
              hex.hasPrefix("#"),
              hex.count == 9 else {
            assertionFailure("missingData")
            return .black
        }

        var colorString = hex
        colorString.removeLast(2)

        guard let color = UIColor(hex: colorString) else {
            assertionFailure("missingData")
            return .black
        }

        return color
    }

    func getOpacity(hexadecimal: Any?) -> Float {
        guard let hex = hexadecimal as? String,
              hex.hasPrefix("#"),
              hex.count == 9 else {
            assertionFailure("missingData")
            return 0.0
        }

        let alpha: Float
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        guard hexColor.count == 8 else {
            assertionFailure("missingData")
            return 0.0
        }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {
            assertionFailure("missingData")
            return 0.0
        }

        alpha = Float(hexNumber & 0x000000ff) / 255
        return alpha
    }
}


// ref: https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
fileprivate extension UIColor {
    convenience init?(hex: String) {
        guard hex.hasPrefix("#") else {
            assertionFailure("missingData")
            return nil
        }

        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...]) + "ff"
        guard hexColor.count == 8 else {
            assertionFailure("missingData")
            return nil
        }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {
            assertionFailure("missingData")
            return nil
        }
        red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        alpha = CGFloat(hexNumber & 0x000000ff) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
        return
    }
}
#endif
