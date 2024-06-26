
import SwiftUI

struct ProductList: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var product: Product? = nil
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(products){product in
                VStack {
                    Button(action:{self.product = product}){
                        ProductListItem(product: product)
                    }
                    Button(action: {
                        withAnimation{
                            cart.addToCart(addedProduct: product, quantity: 1)
                            self.hapticFeedback()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("加入购物车")
                                .font(.caption)
                                .bold()
                        }
                        .padding(8)
                        .background(Color.secondaryBackground)
                        .cornerRadius(18)
                    }).accessibility(identifier: "Add to cart\(product.id)")
                }
                .background(Color.background
                                .cornerRadius(16)
                                .shadow(color: .darkText.opacity(0.05), radius: 2, x: 0.0, y: 0.0))
            }
        }.sheet(item: $product){product in
            ProductView(product: product).environmentObject(cart)
        }
    }
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
