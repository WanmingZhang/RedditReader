//
//  Listing.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

/**
Listing object.
*/

struct Listing : Decodable {
    let kind: String
    let data: ListingData
    
    init(kind: String, data: ListingData) {
        self.kind = ""
        self.data = ListingData(after: "", before: "", children: [], dist: 0, modhash: "")
    }
}

struct ListingData: Decodable {
    let after: String
    let before: String?
    let children: [Post]
    let dist: Int
    let modhash: String
}

struct ChildData : Decodable {
    let author : String?
    let authorFullname : String?
    let title: String?
    let subreddit: String?
    let numComments: Int?
    let preview: listImage?
    let thumbnail: String?
    let thumbnail_height: Int?
    let thumbnail_width: Int?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorFullname = "authorFullname"
        case title = "title"
        case subreddit = "subreddit"
        case numComments = "num_comments"
        case preview = "preview"
        case thumbnail = "thumbnail"
        case thumbnail_height = "thumbnail_height"
        case thumbnail_width = "thumbnail_width"
    }
}
struct Post: Decodable {
    let data: ChildData
    let kind: String?
}

struct listImage: Decodable {
    let images: [ImageStruct]?
    let enabled: Bool?
}

struct ImageStruct: Decodable {
    let resolutions: [Resolution]?
    let id: String?
}

struct Resolution: Decodable {
    let url: String?
    let width: Int?
    let height: Int?
}
