//
//  Item.swift
//  Todoey
//
//  Created by Steven Tay on 18/03/2018.
//  Copyright © 2018 Xiu Design. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
