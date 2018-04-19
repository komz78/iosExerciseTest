//
//  Tags.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//
import Foundation
struct Tags : Codable {
    let id : Int?
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}
