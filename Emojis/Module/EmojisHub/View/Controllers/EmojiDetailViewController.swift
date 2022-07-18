//
//  EmojiDetailViewController.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

/**
        To display the details of the Emoji
 
    This controller is used to display the details of the selected Emoji from the list OR is also used to display the current mood.
    
    To display the current modd, this controller requests view model to fetch the random Emoji details from server and displays
 */
class EmojiDetailViewController: UIViewController {

    var displayCurrentMood: Bool = true
    @IBOutlet weak var lblEmojiName: UILabel!
    @IBOutlet weak var lblEmojiGroup: UILabel!
    @IBOutlet weak var lblEmojiCategory: UILabel!
    
    @IBOutlet weak var lblEmojiIcon: UILabel!
    @IBOutlet weak var indicatorView: CustomIndicator!
    @IBOutlet weak var btnChangeMyMood: CustomButton!
    @IBOutlet weak var vwContainerView: UIView!
    
    private var viewModel = EmojisViewModel()
    var emojiCellViewModel : EmojisCellViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        if displayCurrentMood {
            refreshUIAndBindResponse()
            initializeViewModelProperties()
            getAndDisplayRandomEmoji()
        } else {
            DispatchQueue.main.async {
                self.showLoader_WithState(showLoader: false)
                self.btnChangeMyMood.isHidden = true
                self.refreshUI(withEmoji: self.emojiCellViewModel)
            }
        }
    }

    /**
            Refreshes the UI elemanets
     Do call this method
     - Parameter emoji: model to be supplied to refresh the UI component values.
     If nil, then it will reset the UI component values and will remove the existing values if any.
     */
    func refreshUI(withEmoji emoji: EmojisCellViewModel?) {
        lblEmojiIcon.attributedText = emoji?.htmlCode.convertToAttributedFromHTML(ofSize: 160)
        lblEmojiIcon.layer.borderColor = THEME_COMMON_COLOR.COLOR_MAIN.cgColor
        lblEmojiName.text = emoji?.name ?? "N/A"
        lblEmojiGroup.text = emoji?.getGroupDescription()
        lblEmojiCategory.text = emoji?.getCategoryDescription()
    }

    // MARK: - View Model interactions
    func refreshUIAndBindResponse() {
        // Remove loader here
        viewModel.randomEmoji.bindValue { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshUI(withEmoji: self?.viewModel.randomEmoji.value?.first)
            }
        }
    }
    
    func initializeViewModelProperties() {
        viewModel.updateAPI_LoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.showLoader_WithState(showLoader: true)
                }else {
                    self?.showLoader_WithState(showLoader: false)
                }
            }
        }
        
        self.viewModel.handleError = { [weak self] in
            DispatchQueue.main.async {
                self?.handleAPI_Error()
            }
        }
    }


    func handleAPI_Error() {
        let alert = AlertUtility.alertCon(withTite:ALERT_MESSAGES.TITLE.ERROR_NO_RECORDS.rawValue, withMessage: self.viewModel.apiError, preferredStyle:  UIAlertController.Style.alert.rawValue)
        alert.addAction(UIAlertAction(title: ALERT_ACTION.OK, style: UIAlertAction.Style.cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))

        DispatchQueue.main.async() {
            self.present(alert, animated: true, completion: nil)
        }
    }

    func getAndDisplayRandomEmoji() {
        viewModel.fetchRandomEmojiData()
    }
    
    // MARK: - Indicator View state
    func showLoader_WithState(showLoader show: Bool) {
        DispatchQueue.main.async() {
            self.vwContainerView.isHidden = show
            if show {
                self.indicatorView.startAnimating()
            } else {
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func btnChangeMyMoodClicked(_ sender: Any) {
        getAndDisplayRandomEmoji()
    }
}
