//
//  Product+CoreDataProperties.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var category: String
    @NSManaged public var discription: String
    @NSManaged public var number: Int32
    @NSManaged public var price: Double
    @NSManaged public var rate: Double
    @NSManaged public var title: String
    @NSManaged public var history: NSSet?

}

// MARK: Generated accessors for history
extension Product {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

extension Product : Identifiable {
    var formatedRating: String {
        var result = ""
        for _ in 0...Int(rate){
            result.append("★")
        }
        while result.count<5{
            result += "☆"
        }
        return result
    }
}
