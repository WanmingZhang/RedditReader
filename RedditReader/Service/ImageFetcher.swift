//
//  ImageFetcher.swift
//  RedditReader
//
//  Created by wanming zhang on 2/18/23.
//

import Foundation
import UIKit
import OAuthSwift

protocol ImageFetchProtocol {
    var imageCache: NSCache<NSString, UIImage> { get set }
    var runningReqs: Dictionary<UUID, URLSessionDataTask> { get set }
    
    func getImageFromCache(_ urlStr: NSString) -> UIImage?
    func fetchImageFromUrl(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

class ImageFetcher: ImageFetchProtocol {
    var imageCache = NSCache<NSString, UIImage>()
    var runningReqs = Dictionary<UUID, URLSessionDataTask>()
    
    func getImageFromCache(_ urlStr: NSString) -> UIImage? {
        return imageCache.object(forKey: urlStr)
    }

    func fetchImageFromUrl(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        let str = NSString(string: url.absoluteString)
        // 1 retrieve image from cache
        if let image = getImageFromCache(str) {
            completion(.success(image))
            return nil
        }
        // 2 create uuid for each running task
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            //3
            defer {
                self.runningReqs.removeValue(forKey: uuid)
            }

            // 4
            guard error == nil else {
                // handle error
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
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
                if let httpResponse = response as? HTTPURLResponse {
                    print("fetching image error: status code = \(httpResponse.statusCode)")
                }
                
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }
            
            // 5 cache the image
            self.imageCache.setObject(image, forKey: str)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        
        task.resume()
        
        runningReqs[uuid] = task
        return uuid
    }

    func cancelLoad(_ uuid: UUID) {
        runningReqs[uuid]?.cancel()
        runningReqs.removeValue(forKey: uuid)
    }

}
