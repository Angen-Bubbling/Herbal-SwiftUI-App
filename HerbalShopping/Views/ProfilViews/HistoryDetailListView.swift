import SwiftUI

struct HistoryDetailListView: View {
    let product: Product
    let productQuantities: [String: Int64]
    
    var body: some View {
        HStack(spacing: 16) {
            SmallHistoryListItemImage(imageName: product.title)
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("\(product.price, specifier: "%.2f") ¥")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text("数量: \(productQuantities[product.title] ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.systemGray4), radius: 4, x: 0.0, y: 2)
    }
}



struct SmallHistoryListItemImage: View {
    let imageName: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        ProgressView()
                        HStack {
                            Spacer()
                            Image(imageName)
                                .resizable()
                                .compositingGroup()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
    }
}
