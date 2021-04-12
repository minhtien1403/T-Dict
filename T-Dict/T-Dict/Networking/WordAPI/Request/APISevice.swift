import Foundation
import UIKit

struct APIService {
    
    static let shared = APIService()

    let headers = [
        "x-rapidapi-key": APIKey.key,
        "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
    ]
    
    func request(word: String, type: APIManager, method: HTTPMethod, completion: @escaping (APIResult) -> Void) {
        let urlString = type == .random ? URLs.GetRandomWordURL : "\(URLs.APIGetUrl)/\(word.safeString)/\(type.rawValue)"
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
            guard let data = data, error == nil else{
                completion(.failure(.failedToGetDataFromAPI))
                return
            }
            completion(.success(data))
        })
        dataTask.resume()
    }
    
    func fetchDataFromAPI<T:Codable> (word: String, type: APIManager, completion: @escaping (T?) -> ()) {
        request(word: word, type: type, method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                var response: T?
                do {
                    response = try JSONDecoder().decode(T.self, from: data)
                    completion(response)
                }
                catch{
                    print("json decoder error")
                    print(error.localizedDescription)
                    completion(nil)
                }
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func getDefines(word: String, completion: @escaping (DefinitionResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .definitions, completion: completion)
    }
    
    func getExamples(word: String, completion: @escaping (ExampleResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .examples, completion: completion)
    }
    
    func getSynonyms(word: String, completion: @escaping (SynonysmResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .synonyms, completion: completion)
    }
    
    func getAntonyms(word: String, completion: @escaping (AntonymsResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .antonyms, completion: completion)
    }
    
    func getRhymes(word: String, completion: @escaping (RhymeResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .rhymes, completion: completion)
    }
    
    func getPronounce(word: String, completion: @escaping (PronounceResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .pronunciation, completion: completion)
    }
    
    func getSuggest(word: String, completion: @escaping (SuggestResponse?) -> Void) {
        fetchDataFromAPI(word: word, type: .also, completion: completion)
    }
    
    func getRandomWord(completion: @escaping (RandomWordResponse?) -> Void) {
        fetchDataFromAPI(word: "", type: .random, completion: completion)
    }
}
