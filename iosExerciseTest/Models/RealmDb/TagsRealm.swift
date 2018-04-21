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

final class TagsRealm: Object {
   //enteties
    @objc dynamic var id = ""
    @objc dynamic var label = ""
    //primary key
    override static func primaryKey() -> String? {
        return "id"
    }
}
