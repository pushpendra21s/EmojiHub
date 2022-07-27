//
//  EmojiListViewController.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

class EmojiListViewController: UIViewController {
    
    var viewModel : EmojisViewModel! // Inject view model instead of initializing
    @IBOutlet private weak var tblViewEmojis: UITableView!
    @IBOutlet private weak var indicatorView: CustomIndicator!
    
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
        let alert = AlertUtility.alertCon(withTite:Alert_Messages.Title.errorNoRecords.rawValue, withMessage: self.viewModel.apiError, preferredStyle:  UIAlertController.Style.alert.rawValue)
        alert.addAction(UIAlertAction(title: Alert_Action.ok, style: UIAlertAction.Style.cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        DispatchQueue.main.async() {
            self.present(alert, animated: true, completion: nil)
        }
    }
    // MARK:- Navigation
    private func navigateToEmojiDetails(forDataModel dataModel: EmojisCellViewModel) {
        
        if let vc_EmojiDetails = EmojiUtility.mainStoryboard().instantiateViewController(withIdentifier: "EmojiDetailViewController") as? EmojiDetailViewController {
            vc_EmojiDetails.viewModel = self.viewModel
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
        if let model = viewModel.getEmojiDataSource(forSelectedRow: indexPath.row) {
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell") as? EmojiCell, let model = viewModel.getEmojiDataSource(forSelectedRow: indexPath.row) else {
            return UITableViewCell()
        }

        cell.updateCellValues(withInputModel: model)
        return cell
    }
}
