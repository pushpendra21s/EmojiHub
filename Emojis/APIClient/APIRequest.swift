//
//  APIRequest.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation


struct EMOJI_URL {
    static let EMOJI_HUB_URL    = "https://emojihub.herokuapp.com/api"
}

enum ErrorResponse:String {
    case invalidUrl             = "Invalid query URL."
    case invalidJson            = "Invalid response. Data cannot be decoded."
    case internalServerError    = "Internal server error"
    case unknownError           = "Unknown error"
}


enum Result<String> {
    case success
    case failure(ErrorResponse)
}


protocol ResponseHandler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}
extension ResponseHandler{
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200: return .success
        case 500...599: return .failure(ErrorResponse(rawValue: ErrorResponse.internalServerError.rawValue)!)
        default: return .failure(ErrorResponse(rawValue: ErrorResponse.unknownError.rawValue)!)
        }
    }
}
