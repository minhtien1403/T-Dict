//
//  QuizAPI.swift
//  T-Dict
//
//  Created by Tiến on 4/11/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit
 
struct QuizAPI {
    static let shared = QuizAPI()
    
    let headers = [
        "x-rapidapi-key": APIKey.key,
        "x-rapidapi-host": "twinword-word-association-quiz.p.rapidapi.com"
    ]
    
    func request(level: Int, method: HTTPMethod, completion: @escaping (APIResult) -> Void ) {
        let urlString = String(format: URLs.QuizBaseURL, level)
        guard let url = URL(string: urlString) else {
            completion(.failure(.failedToGetURL))
            return
        }
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
 
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.failedToGetDataFromAPI))
                return
            }
            completion(.success(data))
        })
        dataTask.resume()
    }
    
    func getQuiz(forLevel level: Int, completion: @escaping ([Quiz]?) -> Void) {
        request(level: level, method: .get) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
                var response: QuizResponse?
                do {
                    response = try JSONDecoder().decode(QuizResponse.self, from: data)
                    guard let quizlist = response?.quizlist else {
                        completion(nil)
                        return
                    }
                    completion(quizlist)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
