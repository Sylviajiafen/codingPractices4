//
//  HTTPClient.swift
//  GCDPractice
//
//  Created by Sylvia Jia Fen  on 2019/8/22.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation


enum QueryString: String {
    
    case scope = "resourceAquire"
    
    case rid = "5012e8ba-5ace-4821-8482-ee07c147fd0a"
    
    case limit = "1"
    
}

enum Offset: String {
    
    case zero = "0"
    
    case ten = "10"
    
    case twenty = "20"
    
}


let queryItemScope = URLQueryItem(name: "scope", value: QueryString.scope.rawValue)

let queryItemRid = URLQueryItem(name: "rid", value: QueryString.rid.rawValue)

let queryItemLimit = URLQueryItem(name: "limit", value: QueryString.limit.rawValue)

let queyItemOffsetOfZero = URLQueryItem(name: "offset", value: Offset.zero.rawValue)
    
let queyItemOffsetOfTen = URLQueryItem(name: "offset", value: Offset.ten.rawValue)

let queyItemOffsetOfTwenty = URLQueryItem(name: "offset", value: Offset.twenty.rawValue)

var components = URLComponents()

enum CompleteURL {
    
    case zero
    
    case ten
    
    case twenty
    
    var url: URL? {
        
        switch self {
            
        case .zero:
            
            components.scheme = "https"
            
            components.host = "data.taipei"
            
            components.path = "/opendata/datalist/apiAccess"
            
            components.queryItems = [queryItemScope, queryItemRid, queryItemLimit, queyItemOffsetOfZero]
            
            return components.url
            
        case .ten:
            
            components.scheme = "https"
            
            components.host = "data.taipei"
            
            components.path = "/opendata/datalist/apiAccess"
            
            components.queryItems = [queryItemScope, queryItemRid, queryItemLimit, queyItemOffsetOfTen]
            
            return components.url
            
        case .twenty:
            
            components.scheme = "https"
            
            components.host = "data.taipei"
            
            components.path = "/opendata/datalist/apiAccess"
            
            components.queryItems = [queryItemScope, queryItemRid, queryItemLimit, queyItemOffsetOfTwenty]
            
            return components.url
            
        }
    }
}
