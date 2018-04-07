//
//  Category.swift
//  Todoey
//
//  Created by Steven Tay on 18/03/2018.
//  Copyright © 2018 Xiu Design. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()

}
