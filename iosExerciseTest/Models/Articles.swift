//
//  Articles.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 18/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import Foundation
struct Articles : Codable {
    let title : String?
    let website : String?
    let authors : String?
    let date : String?
    let content : String?
    let tags : [Tags]?
    let image_url : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case website = "website"
        case authors = "authors"
        case date = "date"
        case content = "content"
        case tags = "tags"
        case image_url = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        authors = try values.decodeIfPresent(String.self, forKey: .authors)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }
    
}
