//
//  CustomButton.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    var buttonStyle : ButtonStyle
    
    public enum ButtonStyle: Int {
        case primary
        case secondary
    }
    
    override init(frame: CGRect) {
        self.buttonStyle = .primary
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.buttonStyle = .primary
        super.init(coder: aDecoder)
        
    }
    
    // MARK: - Inspectable Properties
    // MARK: - 
    @IBInspectable var customButtonStyle: Int = 0 {
        didSet {
            
            self.buttonStyle = CustomButton.ButtonStyle(rawValue: customButtonStyle)!
            self.setImage(nil, for: .normal)
            
            switch self.buttonStyle {
            case .primary:
                self.backgroundColor = Theme_Button.primaryColor
                self.setTitleColor(Theme_Button.primaryTitleColor, for: .normal)
                break
                
            case .secondary:
                self.backgroundColor = Theme_Button.secondaryColor
                self.setTitleColor(Theme_Button.secondaryTitleColor, for: .normal)
                self.layer.borderColor = Theme_Button.secondaryTitleColor.cgColor
                self.layer.borderWidth = CGFloat(Theme_Button.borderWidth)
                break
                
            }
            self.layer.cornerRadius = CGFloat(Theme_Button.cornerRadius)
        }
    }
}
