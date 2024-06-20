
import Foundation
import CoreData


extension ProductQuantity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductQuantity> {
        return NSFetchRequest<ProductQuantity>(entityName: "ProductQuantity")
    }

    @NSManaged public var productName: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var history: History?

}

extension ProductQuantity : Identifiable {

}
