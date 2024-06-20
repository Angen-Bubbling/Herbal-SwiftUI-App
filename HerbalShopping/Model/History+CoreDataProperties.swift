
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
    @NSManaged public var quantity: NSSet?

    
    public var productArray: [Product] {
        let set = product as? Set<Product> ?? []
        return set.sorted { $0.title < $1.title }
    }
    
    
}

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

extension History {

    @objc(addQuantityObject:)
    @NSManaged public func addToQuantity(_ value: ProductQuantity)

    @objc(removeQuantityObject:)
    @NSManaged public func removeFromQuantity(_ value: ProductQuantity)

    @objc(addQuantity:)
    @NSManaged public func addToQuantity(_ values: NSSet)

    @objc(removeQuantity:)
    @NSManaged public func removeFromQuantity(_ values: NSSet)

}

extension History : Identifiable {

}
