//
//  ViewController.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import UIKit

class EmojiLandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBActions
    
    @IBAction func btnDisplayAllEmojis(_ sender: Any) {
        navigateToEmojiList()
    }
    
    @IBAction func btnShowMyMoodTodayClicked(_ sender: Any) {
        navigateToEmojiDetails()
    }
    
    
    // MARK: - Navigation
    
    /**
     Navigate to display list of all Emojis
     */
    func navigateToEmojiList() {
        if let vc_EmojiList = EmojiUtility.mainStoryboard().instantiateViewController(withIdentifier: "EmojiListViewController") as? EmojiListViewController {
            vc_EmojiList.viewModel = EmojisViewModel()
            self.navigationController?.pushViewController(vc_EmojiList, animated: true)
        }
    }
    
    /**
     Navigate to display current mood
     
     This method is used to navigate to another details view where a random emojis gets loaded from server.
     */
    func navigateToEmojiDetails() {
        
        if let vc_EmojiDetails = EmojiUtility.mainStoryboard().instantiateViewController(withIdentifier: "EmojiDetailViewController") as? EmojiDetailViewController {
            vc_EmojiDetails.viewModel = EmojisViewModel()
            self.navigationController?.pushViewController(vc_EmojiDetails, animated: true)
        }
    }
}

