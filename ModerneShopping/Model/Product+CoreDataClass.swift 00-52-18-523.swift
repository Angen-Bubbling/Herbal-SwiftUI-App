//
//  Product+CoreDataClass.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/15.
//
//

import Foundation
import CoreData


public class Product: NSManagedObject {
    let manualCount: Int = Int.random(in: 0...500)
}
