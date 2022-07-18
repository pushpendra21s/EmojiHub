//
//  ThemeConstants.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import UIKit

class ThemeConstants: NSObject {

    //
}


struct THEME_COMMON_COLOR
{
    static let COLOR_White        =     UIColor.white
    static let COLOR_MAIN         =     UIColor(red: 69.0/255.0, green: 79.0/255.0, blue: 93.0/255.0,  alpha: 1.0)
}


struct THEME_BUTTON {

    // Color constants
    static let BACKGROUND_PRIMARY_COLOR        = THEME_COMMON_COLOR.COLOR_MAIN
    static let BACKGROUND_SECONDARY_COLOR      = THEME_COMMON_COLOR.COLOR_White
    static let TITLE_COLOR_PRIMARY             = THEME_COMMON_COLOR.COLOR_White
    static let TITLE_COLOR_SECONDARY           = THEME_COMMON_COLOR.COLOR_MAIN
    
    // Other constants
    static let CORNER_RADIUS:CGFloat           = 5.0
}


