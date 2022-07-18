//
//  CustomEmojiCellTableViewCell.swift
//  Emojis
//
//  Created by 918107 on 09/07/2022.
//

import UIKit

class CustomEmojiCell: UITableViewCell {

    @IBOutlet weak var lblEmoji: UILabel!
    @IBOutlet weak var lblEmojiName: UILabel!
    @IBOutlet weak var lblEmojiGroup: UILabel!
    @IBOutlet weak var lblEmojiCategory: UILabel!
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
