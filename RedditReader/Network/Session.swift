//
//  Session.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

/// Session class to communicate with reddit.com
public class Session: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    let cliendId = "RIUiio9zoEya9Ncf6t7eEg"
    
    /// Base URL for public  API
    let baseURL: String
    /// Session object to communicate a server
    var session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// OAuth endpoint URL
    static let OAuthEndpointURL = "https://oauth.reddit.com/"
    
    /// Public endpoint URL
    static let publicEndpointURL = "https://www.reddit.com/"

    /**
    Initialize session object with OAuth token.
    */
    public init(clientID: String) {
        baseURL = Session.OAuthEndpointURL
        super.init()
    }
    
    /**
     Initialize anonymouse session object
     */
    override public init() {
        baseURL = Session.publicEndpointURL
        super.init()
    }
    
}

