//
//  CustomIndicator.swift
//  Emojis
//
//  Created by 918107 on 13/07/2022.
//

import UIKit

@IBDesignable
class CustomIndicator: UIActivityIndicatorView {

    // MARK: - Inspectable Properties
    // MARK: - 
    @IBInspectable var indicatorColor: UIColor = THEME_COMMON_COLOR.COLOR_MAIN {
        didSet {
            self.color = THEME_COMMON_COLOR.COLOR_MAIN//indicatorColor
        }
    }
    

}
