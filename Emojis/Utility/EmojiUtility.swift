//
//  EmojiUtility.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit


var kappdelegate = UIApplication.shared.delegate as! AppDelegate

class EmojiUtility: NSObject {
    
    static var noInternetAlert = UIAlertController()
    
    class func mainStoryboard() -> UIStoryboard {
        return  UIStoryboard(name: App_Stroyboards.main_storyboard, bundle: nil)
    }
    
    //MARK:- CUSTOM LOG
    //MARK:- 
    class func EH_Log(_ logValue:AnyObject?) {
        #if DEBUG
        print(logValue ?? Emoji_Common_Constants.emojiLogNoData)
        #endif
    }
}


extension String {
    /**
     returns optional image for given html string.
     - Parameter px: supply the required image size, preferred in square as emoji will look good in square area.
     */
    
    func convertToAttributedFromHTML(ofSize px: Int = Emoji_Common_Constants.emojiSmallSize_Cell) -> NSAttributedString? {
        let tempStr = "<html><style>h1{font-size: \(px)px; text-align: center;}</style><body><h1>\(self)</h1></body></html>"
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = tempStr.data(using: .unicode, allowLossyConversion: true), let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        return attributedText
    }
}

