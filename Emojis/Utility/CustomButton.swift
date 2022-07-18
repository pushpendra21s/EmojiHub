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
        case Primary            = 0
        case Secondary          = 1
    }
    
    override init(frame: CGRect) {
        self.buttonStyle = .Primary
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.buttonStyle = .Primary
        super.init(coder: aDecoder)
        
    }
    
    // MARK: - Inspectable Properties
    // MARK: - 
    @IBInspectable var customButtonStyle: Int = 0 {
        didSet {
            
            self.buttonStyle = CustomButton.ButtonStyle(rawValue: customButtonStyle)!
            self.setImage(nil, for: .normal)

            switch self.buttonStyle {
            case .Primary:
                self.backgroundColor = THEME_BUTTON.BACKGROUND_PRIMARY_COLOR
                self.setTitleColor(THEME_BUTTON.TITLE_COLOR_PRIMARY, for: .normal)
                break
                
            case .Secondary:
                self.backgroundColor = THEME_BUTTON.BACKGROUND_SECONDARY_COLOR
                self.setTitleColor(THEME_BUTTON.TITLE_COLOR_SECONDARY, for: .normal)
                self.layer.borderColor = THEME_BUTTON.TITLE_COLOR_SECONDARY.cgColor
                self.layer.borderWidth = 1.0
                break

            }
            self.layer.cornerRadius = THEME_BUTTON.CORNER_RADIUS
        }
    }
}
