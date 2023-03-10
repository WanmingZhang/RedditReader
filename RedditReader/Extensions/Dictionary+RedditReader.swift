//
//  Dictionary+RedditReader.swift
//  RedditReader
//
//  Created by wanming zhang on 2/18/23.
//

import Foundation

private let allowedCharacterSet = CharacterSet(charactersIn: "!$&'()*+,-./0123456789:;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~")

/**
Protocol to generate URL query string from Dictionary[String:String].
*/
public protocol QueryEscapableString {
    var addPercentEncoding: String { get }
}

extension String: QueryEscapableString {
    /**
    Returns string by adding percent encoding in UTF-8
    Protocol to generate URL query string from Dictionary[String:String].
    */
    public var addPercentEncoding: String {
        get {
            return (self as NSString).addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
        }
    }
}

/**
Protocol to generate URL query string from Dictionary[String:String].
*/
extension Dictionary where Key: QueryEscapableString, Value: QueryEscapableString {
    /**
    Gets escped string.
    - returns: Returns string by adding percent encoding in UTF-8
    */
    var URLQuery: String {
        get {
            return self.map({"\($0.addPercentEncoding)=\($1.addPercentEncoding)"}).joined(separator: "&")
        }
    }
}
