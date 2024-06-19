//
//  User+CoreDataProperties.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/15.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
