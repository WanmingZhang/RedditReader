//
//  OAuth.swift
//  RedditReader
//
//  Created by wanming zhang on 2/20/23.
//

import Foundation
import OAuthSwift

class OAuthManager {
    static let shared = OAuthManager()
    var oauthswift: OAuth2Swift
    
    private init() {
        let oauthswift = OAuth2Swift(
            consumerKey:    "RIUiio9zoEya9Ncf6t7eEg",
            consumerSecret: "",
            authorizeUrl:   "https://www.reddit.com/api/v1/authorize",
            accessTokenUrl: "https://www.reddit.com/api/v1/access_token",
            responseType:   "code",
            contentType:    "application/json"
        )
        oauthswift.accessTokenBasicAuthentification = true
        self.oauthswift = oauthswift
    }
    
}
