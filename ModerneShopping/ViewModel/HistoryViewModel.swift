//
//  HistoryViewModel.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/18.
//

import Foundation
import CoreData

struct HistoryListItem : Identifiable
{
    let productList : [Product]
    let date : Date
    let id : Int64
    let totalPrice : Double
}

class HistoryViewModel: ObservableObject {
    @Published var historyList : [HistoryListItem] = []
    
    init() {
        fetchHistoryRecords()
        
    }

    func fetchHistoryRecords() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "paytime", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                
                do {
                    let results = try context.fetch(fetchRequest)
                    self.historyList = results.map { history in
                        
//                        if let products = history.product as? Set<Product> {
//                                            print("History ID: \(history.id)")
//                                            print("Products in History:")
//                                            for product in products {
//                                                print("Product: \(product.title), Quantity: \(product.number), Price: \(product.price)")
//                                            }
//                                        }
                        
                        // Fetch related products
                        let products = DatabaseService.shared.fetchProductsByHistory(for: history)
                        return HistoryListItem(
                            productList: products,
                            date: history.paytime,
                            id: history.id,
                            totalPrice:history.totalprice
                        )
                    }
                } catch {
                    print("Failed to fetch history records: \(error)")
                }

    }
}
