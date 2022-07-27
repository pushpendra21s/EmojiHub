//
//  EmojiService.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation

protocol EmojiServiceProtocol {
    func fetchAllEmojis(allEmojiEndPoint endPoint:String, requestCompletion: @escaping (_ object:[Emoji]?,_ error: String?)->())
    func fetchRandomEmoji(randomEmojiEndPoint endPoint:String, requestCompletion: @escaping (_ object:Emoji?,_ error: String?)->())
}

/*
 APIs to integrate
 
 To get list of Emojis          ----    https://emojihub.herokuapp.com/api/all
 To get random Emoji            ----    https://emojihub.herokuapp.com/api/random
 */

struct EMOJI_STUB_ENDPOINT_FILE_NAME {
    static let allEmojis_NoData             = "all_NoData"
    static let allEmojis_InvalidJson        = "all_InvalidJson"
    static let randomEmoji_NoData           = "random_NoData"
    static let randomEmoji_InvalidJson      = "random_InvalidJson"
}

struct EMOJI_ENDPOINT {
    static let All_EMOJIS                   = "/all"
    static let RANDOM_EMOJI                 = "/random"
}

final class EmojiServiceProvider: ResponseHandler, EmojiServiceProtocol {
    
    private let networkClient:NetworkClient
    
    init(withNetworkClient networkC: NetworkClient = NetworkClient()) {
        self.networkClient = networkC
    }
    
    func fetchAllEmojis(allEmojiEndPoint endPoint:String = EMOJI_ENDPOINT.All_EMOJIS, requestCompletion: @escaping (_ object:[Emoji]?,_ error: String?)->()) {
        
        guard let url = self.networkClient.validURL(urlEndPoint: endPoint) else {
            requestCompletion(nil,ErrorResponse.invalidUrl.rawValue)
            return
        }
        
        let request = URLRequest(url: url)
        self.networkClient.loadRequest(request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                return
            }
            
            let result = self.handleNetworkResponse(httpResponse)
            switch result {
            case .success:
                guard let responseData = data else {
                    requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                    return
                }
                do {
                    let emojiModels = try JSONDecoder().decode([Emoji].self, from: responseData)
                    requestCompletion(emojiModels,nil)
                }catch {
                    requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                    return
                }
            case .failure(let errorResponse):
                requestCompletion(nil,errorResponse.rawValue)
            }
        }
    }
    
    func fetchRandomEmoji(randomEmojiEndPoint endPoint:String = EMOJI_ENDPOINT.RANDOM_EMOJI, requestCompletion: @escaping (_ object:Emoji?,_ error: String?)->()) {
        
        guard let url = self.networkClient.validURL(urlEndPoint: endPoint) else {
            requestCompletion(nil,ErrorResponse.invalidUrl.rawValue)
            return
        }
        
        let request = URLRequest(url: url)
        self.networkClient.loadRequest(request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                return
            }
            
            let result = self.handleNetworkResponse(httpResponse)
            switch result {
            case .success:
                guard let responseData = data else {
                    requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                    return
                }
                do {
                    let emojiModel = try JSONDecoder().decode(Emoji.self, from: responseData)
                    requestCompletion(emojiModel,nil)
                    return
                }catch {
                    requestCompletion(nil,ErrorResponse.invalidJson.rawValue)
                    return
                }
            case .failure(let errorResponse):
                requestCompletion(nil,errorResponse.rawValue)
            }
        }
    }
}

// MARK:- Mock Service classe
// MARK:-

class MockEmojiServiceProvider: EmojiServiceProtocol {
    
    let stubClient: StubDataGenerator
    
    var listOfStubEmojis: [Emoji]?
    var randomStubEmoji: Emoji?
    var errorString: String?
    
    var completeClosure_EmojiList: (([Emoji]?, String?) -> ())?
    var completeClosure_RandomEmoji: ((Emoji?, String?) -> ())?
    
    init(withStubClient stubC: StubDataGenerator = StubDataGenerator()) {
        self.stubClient = stubC
    }
    
    func fetchAllEmojis(allEmojiEndPoint endPoint:String = EMOJI_ENDPOINT.All_EMOJIS, requestCompletion: @escaping ([Emoji]?, String?) -> ()) {
        completeClosure_EmojiList = requestCompletion
    }
    
    func fetchRandomEmoji(randomEmojiEndPoint endPoint:String = EMOJI_ENDPOINT.RANDOM_EMOJI, requestCompletion: @escaping (Emoji?, String?) -> ()) {
        completeClosure_RandomEmoji = requestCompletion
    }
    
    // MARK: - Mock responses given
    
    func givenSuccessEmojiList() {
        do {
            listOfStubEmojis = try stubClient.stubEmojis()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    func givenFailure_EmojiList_NoData() {
        do {
            listOfStubEmojis = try stubClient.stubEmojis_AllEmojis_NoData()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    func givenFailure_EmojiList_InvalidResponseFromMockJson() {
        do {
            listOfStubEmojis = try stubClient.stubEmojis_AllEmojis_InvalidJson()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    func givenSuccess_RandomEmojiData() {
        do {
            randomStubEmoji = try stubClient.stubRandomEmoji()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    func givenFailure_RandomEmoji_NoData() {
        do {
            randomStubEmoji = try stubClient.stubEmojis_RandomEmoji_NoData()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    func givenFailure_RandomEmoji_InvalidResponseFromMockJson() {
        do {
            randomStubEmoji = try stubClient.stubEmojis_RandomEmoji_InvalidJson()
        } catch {
            errorString = ErrorResponse.invalidJson.rawValue
        }
    }
    
    
    
    // MARK: - Mock success/ failure fetch methods
    
    func completeEmojiList_Closure() {
        completeClosure_EmojiList?(listOfStubEmojis, errorString)
    }
    
    func completeRandomEmojiData_Closure() {
        completeClosure_RandomEmoji?(randomStubEmoji, errorString)
    }
}
//MARK:-  Stubs Generator
//MARK:-

class StubDataGenerator {
    
    func dataFromFile(fileEndPoint: String) throws -> Data {
        let path = Bundle.main.path(forResource: "contents_\(fileEndPoint)", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw(error)
        }
    }
    
    //MARK:-  Stubs Generators for Success scenario
    
    func stubEmojis() throws -> [Emoji]? {
        do {
            let endpoint = EMOJI_ENDPOINT.All_EMOJIS.replacingOccurrences(of: "/", with: "")
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emojis = try! decoder.decode([Emoji].self, from: mockFileData)
            return emojis
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
    
    func stubRandomEmoji() throws -> Emoji? {
        do {
            let endpoint = EMOJI_ENDPOINT.RANDOM_EMOJI.replacingOccurrences(of: "/", with: "")
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emoji = try decoder.decode(Emoji.self, from: mockFileData)
            return emoji
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
    
    //MARK:-  Stubs Generators for Failure scenario
    
    func stubEmojis_AllEmojis_NoData() throws -> [Emoji]? {
        do {
            let endpoint = EMOJI_STUB_ENDPOINT_FILE_NAME.allEmojis_NoData
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emojis = try decoder.decode([Emoji].self, from: mockFileData)
            return emojis
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
    
    func stubEmojis_AllEmojis_InvalidJson() throws -> [Emoji]? {
        do {
            let endpoint = EMOJI_STUB_ENDPOINT_FILE_NAME.allEmojis_InvalidJson
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emojis = try decoder.decode([Emoji].self, from: mockFileData)
            return emojis
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
    
    func stubEmojis_RandomEmoji_NoData() throws -> Emoji? {
        do {
            let endpoint = EMOJI_STUB_ENDPOINT_FILE_NAME.randomEmoji_NoData
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emoji = try decoder.decode(Emoji.self, from: mockFileData)
            return emoji
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
    
    func stubEmojis_RandomEmoji_InvalidJson() throws -> Emoji? {
        do {
            let endpoint = EMOJI_STUB_ENDPOINT_FILE_NAME.randomEmoji_InvalidJson
            let mockFileData = try dataFromFile(fileEndPoint: endpoint)
            let decoder = JSONDecoder()
            let emoji = try decoder.decode(Emoji.self, from: mockFileData)
            return emoji
            
        } catch {
            // Exception generated while fetching data from json files
            throw(error)
        }
    }
}
