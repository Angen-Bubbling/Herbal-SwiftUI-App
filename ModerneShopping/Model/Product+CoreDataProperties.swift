//
//  Product+CoreDataProperties.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/14.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var discrip: String?

}

extension Product : Identifiable {

}
