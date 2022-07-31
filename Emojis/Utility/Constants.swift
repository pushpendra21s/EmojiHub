//
//  Constants.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation


struct App_Stroyboards
{
    static let main_storyboard                  = "Main"
}

struct Alert_Messages
{
    enum Title:String {
        case error                              = "Error occurred"
        case errorNoRecords                     = "No records found"
        case errorNoInternet                    = "No internet"
    }
    
    enum String_Values:String {
        //MESSAGES
        case failureMessage                     = "Please try again later."
        case serverTimeout                      = "Server timed out"
        case invalidJson                        = "Invalid response."
        case noDataFromServer                   = "No data found"
        case noInternetConnection               = "Please make sure to connect with internet."
    }
    
}

struct Alert_Action {
    static let ok                               = "OK"
    static let cancel                           = "Cancel"
    static let settings                         = "Settings"
}

struct Emoji_Common_Constants {
    // Size properties
    static let emojiSmallSize_Cell              = 80
    static let emojiBigSize_Details             = 160
    static let cornerRadius                     = 5.0
    static let borderWidth                      = 1.0
    
    // Constant properties
    static let emptyCategoryPlaceholder         = "Category : "
    static let emptyGroupPlaceholder            = "Group : "
    static let emptyNA_Placeholder              = "N/A"
    static let emojiLogNoData                   = "No data"
}



