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
    @IBInspectable var indicatorColor: UIColor = Theme_Common_Color.main {
        didSet {
            self.color = Theme_Common_Color.main
        }
    }    
}
