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
    //enteties
    @objc dynamic var title = ""
    let articles = List<ArticleRealm>()
    //primary key
    override static func primaryKey() -> String? {
        return "title"
    }
    
}






