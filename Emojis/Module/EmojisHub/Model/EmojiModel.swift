//
//  EmojiModel.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation

// Sample response from API
/*
 {
     "name": "grinning face",
     "category": "smileys and people",
     "group": "face positive",
     "htmlCode": [
       "&#128512;"
     ],
     "unicode": [
       "U+1F600"
     ]
   }
 */

struct EmojiHub: Decodable {
    var emojis: [Emoji]
}

struct Emoji: Decodable {
    var name: String
    var category: String
    var group: String
    var htmlCode: [String]
    var unicode: [String]
}
