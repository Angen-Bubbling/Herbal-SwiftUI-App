//
//  History+CoreDataProperties.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/18.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var paytime: Date
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var amount: Int32
    @NSManaged public var price: Double

}

extension History : Identifiable {

}
