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
    
    //MARK:- Common methods
    //MARK:-
    class func hideNoInternetAlertIfPresented() {
        if noInternetAlert.isBeingPresented {
            noInternetAlert.dismiss(animated: false, completion: {
            })
        }
    }
    
    class func showNoInternetAlert() {
        let strTitle = Alert_Messages.Title.errorNoInternet.rawValue
        let strDesc = Alert_Messages.String_Values.noInternetConnection.rawValue
        
        let cancelButton = Alert_Action.ok
        let settingsButton = Alert_Action.settings
        
        EmojiUtility.hideNoInternetAlertIfPresented()
        
        noInternetAlert = AlertUtility.alertCon(withTite:strTitle, withMessage: strDesc, preferredStyle:  UIAlertController.Style.alert.rawValue)
        noInternetAlert.addAction(UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel, handler: { action in
            
        }))
        
        let somethingAction = UIAlertAction(title: settingsButton, style: UIAlertAction.Style.default, handler: { action in
            noInternetAlert.dismiss(animated: true, completion: nil)
            EmojiUtility.openSettingOption()
            
        })
        noInternetAlert.addAction(somethingAction)
        noInternetAlert.preferredAction = somethingAction
        
        DispatchQueue.main.async() {
            UIApplication.shared.delegate?.window!?.rootViewController?.present(noInternetAlert, animated: true, completion: nil)
        }
        
        return
        
    }
    
    class func openSettingOption()
    {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                let _ =  UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
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

