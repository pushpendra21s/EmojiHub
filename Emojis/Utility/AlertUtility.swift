//
//  AlertUtility.swift
//  Emojis
//
//  Created by 918107 on 10/07/2022.
//

import UIKit

class AlertUtility: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func alertCon(withTite title: String, withMessage message: String?, preferredStyle: Int) -> UIAlertController {
        // Adding observer to the alert
        let alert = AlertUtility(title: title, message: message, preferredStyle: UIAlertController.Style(rawValue: preferredStyle)!)
        NotificationCenter.default.addObserver(alert, selector: #selector(hideAlertController), name: NSNotification.Name(rawValue: NOTIFICATION_OBSERVER_CONSTANTS.N_O_C_ALERT_DISMISS), object: nil)
        return alert
    }
    
    @objc func hideAlertController() {
        self.dismiss(animated: true, completion: nil)
    }

}
