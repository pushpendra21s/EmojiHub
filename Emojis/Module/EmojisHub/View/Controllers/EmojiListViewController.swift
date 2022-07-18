//
//  EmojiListViewController.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

class EmojiListViewController: UIViewController {

    var emojisHubModel: EmojiHub?
    @IBOutlet weak var indicatorView: CustomIndicator!
    var viewModel : EmojisViewModel! // Inject view model instead of initializing
    @IBOutlet weak var tblViewEmojis: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModelProperties()
        fetchListOfAllEmojis()
    }
    
    func initializeViewModelProperties() {
        viewModel.updateAPI_LoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.indicatorView.startAnimating()
                }else {
                    self?.indicatorView.stopAnimating()
                }
            }
        }
        
        self.viewModel.handleError = { [weak self] in
            DispatchQueue.main.async {
                self?.handleAPI_Error()
            }
        }
        
        viewModel.emojis.bindValue { [weak self] _ in
            DispatchQueue.main.async {
                self?.tblViewEmojis.reloadData()
            }
        }
    }
    
    func fetchListOfAllEmojis() {
        viewModel.fetchAllEmojiData()
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
    // MARK:- Navigation
    private func navigateToEmojiDetails(forDataModel dataModel: EmojisCellViewModel) {
        
        if let vc_EmojiDetails = EmojiUtility.mainStoryboard().instantiateViewController(withIdentifier: "EmojiDetailViewController") as? EmojiDetailViewController {
            vc_EmojiDetails.displayCurrentMood = false
            vc_EmojiDetails.emojiCellViewModel = dataModel
            self.navigationController?.pushViewController(vc_EmojiDetails, animated: true)
        }
    }

    
}

// MARK: - UITableview Delegate
// MARK: -
extension EmojiListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel.getEmojiCellViewModel(forSelectedRow: indexPath.row) {
            // Navigate to the details page
            navigateToEmojiDetails(forDataModel: model)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableview Datasource
// MARK: -

extension EmojiListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows_EmojiList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = viewModel.getEmojiCellViewModel(forSelectedRow: indexPath.row) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomEmojiCell") as? CustomEmojiCell {
                cell.updateCellValues(withInputModel: model)
                return cell
            }
        }
        return UITableViewCell()
    }
}
