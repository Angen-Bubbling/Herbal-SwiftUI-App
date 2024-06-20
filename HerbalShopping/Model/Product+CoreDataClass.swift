
import Foundation
import CoreData


public class Product: NSManagedObject {
    let manualCount: Int = Int.random(in: 0...500)
}
