//
//  EmojiCellTableViewCell.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

class EmojiCell: UITableViewCell {
    
    @IBOutlet private weak var lblEmoji: UILabel!
    @IBOutlet private weak var lblEmojiName: UILabel!
    @IBOutlet private weak var lblEmojiGroup: UILabel!
    @IBOutlet private weak var lblEmojiCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCellValues(withInputModel emojiCellViewModel: EmojisCellViewModel) {
        lblEmoji.attributedText = emojiCellViewModel.htmlCode.convertToAttributedFromHTML()
        lblEmojiName.text = emojiCellViewModel.name
        lblEmojiGroup.text = emojiCellViewModel.getGroupDescription()
        lblEmojiCategory.text = emojiCellViewModel.getCategoryDescription()
    }
}
