//
//  ModelData.swift
//  GCDPractice
//
//  Created by Sylvia Jia Fen  on 2019/8/22.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

struct Result: Codable {
    
    let result: Results
}

struct Results: Codable {
    
    let results: [result]
    
}

struct result: Codable {
    
    let functions: String
    
    let area : String
    
    let no: String
    
    let direction: String
    
    let speedLimit: String
    
    let location: String
    
    let id: Int
    
    let road: String
    
    enum CodingKeys: String, CodingKey {
        
        case functions
        
        case area
        
        case no
        
        case direction
        
        case speedLimit = "speed_limit"
        
        case location
        
        case id = "_id"
        
        case road
    }
}
