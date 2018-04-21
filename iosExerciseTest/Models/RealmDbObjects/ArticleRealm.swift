//
//  File.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 21/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class ArticleRealm: Object {
    //enteties
    @objc dynamic var title = ""
    @objc dynamic var website = ""
    @objc dynamic var authors = ""
    @objc dynamic var date = ""
    @objc dynamic var content = ""
    let tagsItem = List<TagsRealm>()
    @objc dynamic var image_url = ""
    //primary key
    override static func primaryKey() -> String? {
        return "title"
    }
}
