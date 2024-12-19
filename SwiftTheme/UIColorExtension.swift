//
//  UIColorExtension.swift
//  HEXColor
//
//  Created by R0CKSTAR on 6/13/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit

/**
 Errors that can occur when parsing a string representation of a `UIColor`.
 
 - `missingHashMarkAsPrefix`: The string is missing the `#` prefix.
 - `unableToScanHexValue`: The hex value in the string could not be scanned.
 - `mismatchedHexStringLength`: The number of characters after the `#` prefix is not 3, 4, 6, or 8.
 - `invalidRGBAFormat`: The string does not contain a valid RGBA format.
 */

public enum UIColorInputError: Error {
    case missingHashMarkAsPrefix
    case unableToScanHexValue
    case mismatchedHexStringLength
    case invalidRGBAFormat
}

@objc extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
        Initializes a UIColor from an RGBA string representation.

        - Parameter rgba: A string representing the color in one of the supported formats.

        ## Supported Formats:
        - `#RRGGBB`: A hexadecimal representation of the color without alpha.
        - `#RRGGBBAA`: A hexadecimal representation of the color with alpha.
        - `rgba(r, g, b, a)`: A functional representation of the color with red, green, blue, and alpha values.

        - Throws: An error if the provided string is not in a supported format or cannot be parsed.

        ## Usage:
        ```swift
        let color = UIColor(rgba: "#FF5733")
        let colorWithAlpha = UIColor(rgba: "#FF573380")
        let colorFromRGBA = UIColor(rgba: "rgba(255, 87, 51, 0.5)")
        ```
    */
    public convenience init(rgba_throws rgba: String) throws {
        // Check if it's an rgba() format
        if rgba.hasPrefix("rgba(") && rgba.hasSuffix(")") {
            try self.init(rgbaFunction: rgba)
            return
        }

        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        let hexString: String = String(rgba[rgba.index(rgba.startIndex, offsetBy: 1)...])
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }

        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }

    /// Initialize UIColor from rgba string
    /// Supports formats:
    /// - #RRGGBB
    /// - #RRGGBBAA
    /// - rgba(r, g, b, a)
    public convenience init(rgba: String) throws {
        // Check if it's an rgba() format
        if rgba.hasPrefix("rgba(") && rgba.hasSuffix(")") {
            try self.init(rgbaFunction: rgba)
            return
        }

        // Check if it's a hex color
        try self.init(rgba_throws: rgba)
    }

    /// Initialize UIColor from rgba function string
    /// - Parameter rgbaFunction: String in format "rgba(r, g, b, a)"
    /// - Throws: UIColorInputError if parsing fails
    private convenience init(rgbaFunction rgba: String) throws {
        // Remove "rgba(" and ")" and split by comma
        let componentsString = rgba
            .replacingOccurrences(of: "rgba(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        let components = componentsString
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        // Ensure we have 4 components (R, G, B, Alpha)
        guard components.count == 4 else {
            throw UIColorInputError.invalidRGBAFormat
        }
        
        // Parse numeric values
        guard
            let red = Float(components[0]),
            let green = Float(components[1]),
            let blue = Float(components[2]),
            let alpha = Float(components[3])
        else {
            throw UIColorInputError.invalidRGBAFormat
        }
        
        // Create color
        self.init(
            red: CGFloat(red / 255.0),
            green: CGFloat(green / 255.0),
            blue: CGFloat(blue / 255.0),
            alpha: CGFloat(alpha)
        )
    }

    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
     
     - parameter rgba: String value.
     */
    public convenience init(rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    /**
     Hex string of a UIColor instance.
     
     - parameter rgba: Whether the alpha should be included.
     */
    public func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(round(r * 255)), Int(round(g * 255)), Int(round(b * 255)), Int(round(a * 255)))
        } else {
            return String(format: "#%02X%02X%02X", Int(round(r * 255)), Int(round(g * 255)), Int(round(b * 255)))
        }
    }
    
    open override var description: String {
        return self.hexString(true)
    }
    
    open override var debugDescription: String {
        return self.hexString(true)
    }
}
