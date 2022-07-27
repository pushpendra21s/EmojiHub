//
//  ThemeConstants.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import UIKit

struct Theme_Common_Color
{
    static let white        =     UIColor.white
    static let main         =     UIColor(red: 69.0/255.0, green: 79.0/255.0, blue: 93.0/255.0,  alpha: 1.0)
}


struct Theme_Button {
    
    // Color constants
    static let primaryColor                    = Theme_Common_Color.main
    static let secondaryColor                  = Theme_Common_Color.white
    static let primaryTitleColor               = Theme_Common_Color.white
    static let secondaryTitleColor             = Theme_Common_Color.main
    
    // Other constants
    static let cornerRadius                    = Emoji_Common_Constants.cornerRadius
    static let borderWidth                     = Emoji_Common_Constants.borderWidth
}


