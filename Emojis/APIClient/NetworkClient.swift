//
//  NetworkClient.swift
//  Emojis
//
//  Created by 918107 on 06/07/2022.
//

import Foundation

public typealias NetworkRouterCompletionHandler = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    func loadRequest(_ request: URLRequest, onCompletion: @escaping NetworkRouterCompletionHandler)
    func cancelRequest()
}


internal final class NetworkClient: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func validURL(urlEndPoint: String) -> URL? {
        let urlString = EMOJI_URL.EMOJI_HUB_URL + urlEndPoint
        EmojiUtility.EH_Log("API URL --- \(urlString) " as AnyObject)
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    func loadRequest(_ request: URLRequest, onCompletion: @escaping NetworkRouterCompletionHandler) {
        
        let session = URLSession.shared
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                
                EmojiUtility.EH_Log("API URL --- \(String(describing: request.url?.absoluteString))" as AnyObject)
                if let resp = response as? HTTPURLResponse {
                    let statusCode = "\(resp.statusCode)"
                    EmojiUtility.EH_Log("API RESPONSE CODE--- \(statusCode)" as AnyObject)
                }
                
                if let err = error {
                    EmojiUtility.EH_Log("API ERROR--- \(err.localizedDescription)" as AnyObject)
                }
                onCompletion(data, response, error)
            }
        })
        self.task?.resume()
    }
    
    func cancelRequest() {
        self.task?.cancel()
    }
}
