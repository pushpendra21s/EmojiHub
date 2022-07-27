//
//  EmojisViewModel.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation


class EmojisViewModel: ResponseHandler {
    var allEmojisDataModel: [Emoji]?
    var randomEmojiDataModel : Emoji?
    var emojis: DataObservable<[EmojisCellViewModel]> = DataObservable([])
    var randomEmoji: DataObservable<[EmojisCellViewModel]> = DataObservable([])
    var handleError: (()->())?
    var apiError : String?
    var updateAPI_LoadingStatus: (()->())?
    private let emojiApiService: EmojiServiceProtocol
    
    var isLoading: Bool = false {
        didSet {
            self.updateAPI_LoadingStatus?()
        }
    }
    
    init(apiService: EmojiServiceProtocol = EmojiServiceProvider() ) {
        self.emojiApiService = apiService
    }
    
    func fetchAllEmojiData() {
        self.isLoading = true
        self.emojiApiService.fetchAllEmojis(allEmojiEndPoint: EMOJI_ENDPOINT.All_EMOJIS) { [weak self] (emojis, errorString) in
            self?.isLoading = false
            if let errorMsg = errorString {
                self?.apiError = errorMsg
                self?.handleError?()
            } else {
                self?.allEmojisDataModel = emojis
                self?.bindCellViewModelData()
            }
        }
    }
    
    func fetchRandomEmojiData() {
        self.isLoading = true
        self.emojiApiService.fetchRandomEmoji(randomEmojiEndPoint: EMOJI_ENDPOINT.RANDOM_EMOJI) { [weak self] (emoji, errorString) in
            self?.isLoading = false
            if let errorMsg = errorString {
                self?.apiError = errorMsg
                self?.handleError?()
            } else {
                self?.randomEmojiDataModel = emoji
                self?.bindCellViewModelDataForRandomEmoji()
            }
        }
    }
    
    
    // MARK:- Cell ViewModel Data source
    func bindCellViewModelData() {
        self.emojis.value = self.allEmojisDataModel?.compactMap({
            EmojisCellViewModel(name: $0.name, category: $0.category, group: $0.group, htmlCode: $0.htmlCode.first ?? "", uniCode: $0.unicode.first ?? "")
        })
    }
    
    func bindCellViewModelDataForRandomEmoji() {
        if let emoji = self.randomEmojiDataModel {
            self.randomEmoji.value = [EmojisCellViewModel(name: emoji.name, category: emoji.category, group: emoji.group, htmlCode: emoji.htmlCode.first ?? "", uniCode: emoji.unicode.first ?? "")]
        }
    }
    
    func getEmojiDataSource(forSelectedRow row: Int) -> EmojisCellViewModel? {
        return self.emojis.value?[row]
    }
    
    func numberOfRows_EmojiList() -> Int {
        return self.emojis.value?.count ?? 0
    }
    
}

// MARK:- Cell ViewModel
// MARK:-

/**
 View model for Emoji List cell view.
 
 UI will only understand the EmojisCellViewModel in order to render the data in tableView cell. If any data is to be passed then those models have to converted back to EmojisCellViewModel.
 */


struct EmojisCellViewModel {
    let name: String
    let category: String
    let group: String
    let htmlCode: String
    let uniCode: String
    
    func getCategoryDescription() -> String {
        return "\(Emoji_Common_Constants.emptyCategoryPlaceholder)\(self.category.count > 0 ? self.category : Emoji_Common_Constants.emptyNA_Placeholder)"
    }
    
    func getGroupDescription() -> String {
        return "\(Emoji_Common_Constants.emptyGroupPlaceholder)\(self.group.count > 0 ? self.group : Emoji_Common_Constants.emptyGroupPlaceholder)"
    }
}
