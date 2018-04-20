//
//  jsonBase.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import Foundation
struct JsonBase : Codable {
    let title : String?
    let articles : [Articles]?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        articles = try values.decodeIfPresent([Articles].self, forKey: .articles)
    }
    
}
