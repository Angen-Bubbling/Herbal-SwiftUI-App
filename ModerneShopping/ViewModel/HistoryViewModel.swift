//
//  HistoryViewModel.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/18.
//

import Foundation
import CoreData

class HistoryViewModel: ObservableObject {
    @Published var historyRecords: [HistoryRecord] = []

    init() {
        fetchHistoryRecords()
    }

    func fetchHistoryRecords() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        
        do {
            let histories = try context.fetch(fetchRequest)
            self.historyRecords = histories.map { history in
                HistoryRecord(
                    date: formatDate(history.paytime),
                    content: "Product: \(history.name)\nAmount: \(history.amount)\nPrice: \(history.price)"
                )
            }
        } catch {
            print("Failed to fetch history records: \(error)")
        }
    }

    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Unknown Date" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

