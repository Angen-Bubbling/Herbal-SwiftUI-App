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

    @NSManaged public var id: Int64
    @NSManaged public var paytime: Date
    @NSManaged public var totalprice: Double
    @NSManaged public var product: NSSet?
    
    public var productArray: [Product] {
           let set = product as? Set<Product> ?? []
           return set.sorted { $0.title < $1.title }
       }

}

// MARK: Generated accessors for product
extension History {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Product)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Product)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension History : Identifiable {

}
