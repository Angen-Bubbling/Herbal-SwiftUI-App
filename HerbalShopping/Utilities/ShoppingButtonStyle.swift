
import SwiftUI

struct AddCartButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(systemName: self.isPressed ? "cart.badge.plus" : "cart")
                Spacer()
            }
            HStack {
                Spacer()
                if self.isPressed {
                    Text("加入购物车").bold()
                        .foregroundColor(.tertiary)
                } else {
                    configuration.label
                }
                Spacer()
            }
        }
        .foregroundColor(.tertiary)
        .padding()
        .background(
            Group{
                if self.isPressed {
                    Color.green
                } else {
                    Color.darkText
                }
            }
        )
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
