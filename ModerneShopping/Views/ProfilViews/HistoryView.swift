//
//  HistoryView.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/16.
//

import SwiftUI

struct HistoryRecord: Identifiable {
    let id = UUID()
    let date: String
    let content: String
}

struct HistoryDetailView: View {
    var record: HistoryRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(record.date)
                .font(.largeTitle)
            Text(record.content)
                .font(.body)
        }
        .padding()
    }
}

struct HistoryView: View {
    @StateObject var history =  HistoryViewModel()
    @State private var selectedRecord: HistoryRecord?
    
    var body: some View {
        List(history.historyRecords) { record in
            Button(action: {
                selectedRecord = record
            }) {
                VStack(alignment: .leading) {
                    Text(record.date)
                        .font(.headline)
                    Text(record.content)
                        .font(.subheadline)
                }
                .padding(.vertical, 4)
            }
        }
        .sheet(item: $selectedRecord) { record in
            HistoryDetailView(record: record)
        }
        .navigationTitle("购买记录")
    }
}

#Preview {
    HistoryView()
}
