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
    @IBOutlet private weak var lblEmojiName: UILabel!
    @IBOutlet private weak var lblEmojiGroup: UILabel!
    @IBOutlet private weak var lblEmojiCategory: UILabel!
    
    @IBOutlet private weak var lblEmojiIcon: UILabel!
    @IBOutlet private weak var indicatorView: CustomIndicator!
    @IBOutlet private weak var btnChangeMyMood: CustomButton!
    @IBOutlet private weak var vwContainerView: UIView!
    
    var viewModel : EmojisViewModel! // Inject view model instead of initializing
    var emojiCellViewModel : EmojisCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decideEmojiDetailsJourney()
    }
    
    /**
     Decides emoji detail journey based on flag value supplied
     
     Flag displayCurrentMood is used to decide and refresh the UI component values for this details page.
     If true, then it will reset the UI component values and will remove the existing values if any.
     */
    private func decideEmojiDetailsJourney() {
        initializeViewModelProperties()
        if displayCurrentMood {
            fetchRandomEmojiData()
        } else {
            DispatchQueue.main.async {
                self.viewModel.isLoading = false
                self.btnChangeMyMood.isHidden = true
                self.refreshUI(withEmoji: self.emojiCellViewModel)
            }
        }
    }
    
    /**
     Refreshes the UI elemanets
     
     - Parameter emoji: model to be supplied to refresh the UI component values.
     If nil, then it will reset the UI component values and will remove the existing values if any.
     */
    private func refreshUI(withEmoji emoji: EmojisCellViewModel?) {
        lblEmojiIcon.attributedText = emoji?.htmlCode.convertToAttributedFromHTML(ofSize: Emoji_Common_Constants.emojiBigSize_Details)
        lblEmojiIcon.layer.borderColor = Theme_Common_Color.main.cgColor
        lblEmojiName.text = emoji?.name ?? Emoji_Common_Constants.emptyNA_Placeholder
        lblEmojiGroup.text = emoji?.getGroupDescription()
        lblEmojiCategory.text = emoji?.getCategoryDescription()
    }
    
    // MARK: - View Model interactions
    private func initializeViewModelProperties() {
        viewModel.randomEmoji.bindValue { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshUI(withEmoji: self?.viewModel.randomEmoji.value?.first)
            }
        }

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
        let alert = AlertUtility.alertCon(withTite:Alert_Messages.Title.errorNoRecords.rawValue, withMessage: self.viewModel.apiError, preferredStyle:  UIAlertController.Style.alert.rawValue)
        alert.addAction(UIAlertAction(title: Alert_Action.ok, style: UIAlertAction.Style.cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        DispatchQueue.main.async() {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func fetchRandomEmojiData() {
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
        fetchRandomEmojiData()
    }
}
