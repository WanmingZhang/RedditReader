//
//  Session+listings.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

protocol ListServiceProtocol {

    func getList(_ paginator: Paginator, type: String, limit: Int, completion: @escaping (Result<Listing, Error>) -> Void)
    
}

class ListService: ListServiceProtocol {
    /**
    Get lists from all subreddits
    - parameter type: ListType
    - parameter paginator: Paginator object for paging contents.
    - parameter completion:
     */
    //private let limit = 5
    
    func getList(_ paginator: Paginator, type: String, limit: Int = 5, completion: @escaping (Result<Listing, Error>) -> Void) {
        
        getList(paginator, type: type, subreddit: nil, limit: limit, completion: completion)
    }

    func getList(_ paginator: Paginator, type: String, subreddit: String?, limit: Int = 5, completion: @escaping (Result<Listing, Error>) -> Void) {
        let parameter = paginator.dictionaryByAdding(parameters: [
            "limit": "\(limit)",
            "show": "all"
            ])
        
        var path = "\(type).json"
        if let subreddit = subreddit {
            path = "\(subreddit)/\(type).json"
            
        }
        let baseURL = Session().baseURL
        let method = "GET"
        guard let request = buildRequest(with: baseURL, path: path, method: method, parameter: parameter) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                // handle error
                completion(.failure(error!))
                return
            }
            guard let response = response else {
                // handle error
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  case 200...299 = httpResponse.statusCode
            else {
                // handle error
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let list = try decoder.decode(Listing.self, from: data)
                    completion(.success(list))
                } catch let error {

                    completion(.failure(error))
                }
            }
        }

        task.resume()
                
    }
    
    func buildRequest(with baseURL: String, path: String, method: String, parameter: [String: String]) -> URLRequest? {
        let param = parameter.URLQuery
        guard let URL = param.isEmpty ? URL(string: baseURL + path) : URL(string: baseURL + path + "?" + param) else { return nil }
        var request = URLRequest(url: URL)
        request.httpMethod = method
        return request
    }

}
