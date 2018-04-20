//
//  RealmObjects.swift
//  iosExerciseTest
//
//  Created by Komil Bagshi on 20/04/2018.
//  Copyright © 2018 Komil Bagshi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

//// MARK: Model

final class ArticlesList: Object {
    @objc dynamic var title = ""
    let articles = List<ArticleRealm>()

    override static func primaryKey() -> String? {
        return "title"
    }
}

final class ArticleRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var website = ""
    @objc dynamic var authors = ""
    @objc dynamic var date = ""
    @objc dynamic var content = ""
    let tagsItem = List<TagsRealm>()
    @objc dynamic var image_url = ""
    override static func primaryKey() -> String? {
        return "title"
    }
}

final class TagsRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var label = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}


