//
//  Constants.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation


struct APP_STORYBOARDS
{
    static let MAIN_STORYBOARD                  = "Main"
}

struct ALERT_MESSAGES
{
    enum TITLE:String {
        case ERROR                              = "Error occurred"
        case ERROR_NO_RECORDS                   = "No records found"
        case NO_INTERNET_CONNECTION             = "No internet"
    }

    enum STRING_VALUES:String {
        //MESSAGES
        case FAILURE_MESSAGE                    = "Please try again later."
        case SERVER_TIMEOUT                     = "Server timed out"
        case INVALID_JSON                       = "Invalid response."
        case NO_DATA_FROM_SERVER                = "No data found"
        case NO_INTERNET_CONNECTION             = "Please make sure to connect with internet."
    }
    
}

struct ALERT_ACTION {
    static var OK                               : String{return "OK"}
    static var CANCEL                           : String{return "Cancel"}
    static var SETTINGS                         : String{return "Settings"}
}

struct NOTIFICATION_OBSERVER_CONSTANTS
{
    static let N_O_C_ALERT_DISMISS              = "DismissAllAlertsNotification"

}


