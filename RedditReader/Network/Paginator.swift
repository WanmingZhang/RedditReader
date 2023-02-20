//
//  Paginator.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

/**
Paginator object for paiging listing object.
*/
public struct Paginator {
    let after: String
    let before: String
    
    public init() {
        self.after = ""
        self.before = ""
    }
    
    public init(after: String, before: String) {
        self.after = after
        self.before = before
    }
    
    public var isVacant: Bool {
        if (!after.isEmpty) || (!before.isEmpty) {
            return false
        }
        return true
    }
    
    /**
    Generate dictionary to add query parameters to URL.
    If paginator is vacant, returns vacant dictionary as [String:String].
    
    - returns: Dictionary object for paging.
    */
    public var parameterDictionary: [String: String] {
        get {
            var dict: [String: String] = [:]
            if !after.isEmpty {
                dict["after"] = after
            }
            if !before.isEmpty {
                dict["before"] = before
            }
            return dict
        }
    }
    
    public func dictionaryByAdding(parameters dict: [String: String]) -> [String: String] {
        var newDict = dict
        if !after.isEmpty {
            newDict["after"] = after
        }
        if !before.isEmpty {
            newDict["before"] = before
        }
        return newDict
    }
}
