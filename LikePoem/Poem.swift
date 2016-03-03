//
//  Poem.swift
//  LikePoem
//
//  Created by wyatt on 16/3/2.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import Foundation
import RealmSwift

class Poem: Object {
    
    dynamic var author = ""
    dynamic var title = ""
    dynamic var createAt = NSDate()
    dynamic var content = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
