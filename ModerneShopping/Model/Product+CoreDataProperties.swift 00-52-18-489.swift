//
//  Product+CoreDataProperties.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/15.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var discription: String
    @NSManaged public var price: Double
    @NSManaged public var title: String
    @NSManaged public var category: String
    @NSManaged public var number: Int32
    @NSManaged public var rate: Double
    
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
