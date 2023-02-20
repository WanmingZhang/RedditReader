//
//  Session.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

/// Session class to communicate with reddit.com
public class Session: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    /// Base URL for public  API
    let baseURL: String
    /// Session object to communicate a server
    var session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// Public endpoint URL
    static let publicEndpointURL = "https://www.reddit.com/"

    /**
     Initialize anonymouse session object
     */
    override public init() {
        baseURL = Session.publicEndpointURL
        super.init()
    }
    
}

