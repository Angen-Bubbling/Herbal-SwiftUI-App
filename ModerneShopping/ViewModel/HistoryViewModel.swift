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
    let productQuantities: [String: Int64]
    let date : Date
    let id : Int64
    let totalPrice : Double
}

class HistoryViewModel: ObservableObject {
    @Published var historyList: [HistoryListItem] = []

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
                // Fetch related products and quantities
                var productQuantities: [String: Int64] = [:]
                var products: [Product] = []

                if let quantities = history.quantity as? Set<ProductQuantity> {
                    for quantity in quantities {
                        if let productName = quantity.productName {
                            productQuantities[productName] = quantity.quantity
                            if let product = (history.product as? Set<Product>)?.first(where: { $0.title == productName }) {
                                products.append(product)
                            }
                        }
                    }
                }

                let historyItem = HistoryListItem(
                                    productList: products,
                                    productQuantities: productQuantities,
                                    date: history.paytime,
                                    id: history.id,
                                    totalPrice: history.totalprice
                                )
                                print("History ID: \(historyItem.id), Date: \(historyItem.date), Total Price: \(historyItem.totalPrice), Products: \(historyItem.productList), Quantities: \(historyItem.productQuantities)")
                                return historyItem
            }
        } catch {
            print("Failed to fetch history records: \(error)")
        }
    }
}
