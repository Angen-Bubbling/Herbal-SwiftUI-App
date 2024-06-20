
import SwiftUI

struct HistoryDetailView: View {
    let record: HistoryListItem

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("购买详情")
                        .font(.title2).bold()
                    Spacer()
                }.padding()
                Text("购买时间: \(record.date, formatter: dateFormatter)")
                    .font(.headline)
                ScrollView {
                        VStack {
                            ForEach(record.productList, id: \.self) { product in
                                HistoryDetailListView(product: product,productQuantities: record.productQuantities)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding()
                    }
                
                Text("总计：\(record.totalPrice, specifier: "%.2f")¥")
                    .padding(.top, 15)
            }
            .padding()
        }
        .accentColor(.darkText)
    }
}

