//
//  HistoryView.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/16.
//

import SwiftUI


struct HistoryView: View {
    @StateObject var history =  HistoryViewModel()
    @State private var selectedRecord: HistoryListItem?
    
    var body: some View {
        List(history.historyList) { record in
            Button(action: {
                selectedRecord = record
            }) {
                VStack(alignment: .leading) {
                    Text("购买时间: \(record.date, formatter: dateFormatter)")
                        .font(.headline)
                    Text("总价: \(record.totalPrice, specifier: "%.2f")")
                        .font(.subheadline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(record.productList, id: \.self) { product in
                                if let image = UIImage(named:product.title){
                                    Image(uiImage:image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                        .shadow(radius: 5)
                                        .padding(2)
                                }
                            }
                        }
                    }
                    .frame(height: 100) // Set a fixed height for the scroll view
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

public let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    HistoryView()
}
