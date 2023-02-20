//
//  NetworkError.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case canNotCreateURLRequest
    case failedToParseListingFromJsonObject
    case commentJsonObjectIsMalformed
    // Throw in all other cases
    case unexpected(code: Int)
    
    public var description: String {
        switch self {
        case .canNotCreateURLRequest:
            return "can not create URLRequest."
        case .failedToParseListingFromJsonObject:
            return "failed to parse listing from Json."
        case .commentJsonObjectIsMalformed:
            return "comment Json object is malformed."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}
