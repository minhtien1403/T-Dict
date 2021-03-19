import Foundation

struct APIService {
    
    static let shared = APIService()

    let headers = [
        "x-rapidapi-key": APIKey.key,
        "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
    ]
    
    func request(word: String, type: APIManager, method: HTTPMethod, completion: @escaping (APIResult) -> Void) {
        let urlString = "\(URLs.APIGetUrl)/\(word)/\(type.rawValue)"
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
}
