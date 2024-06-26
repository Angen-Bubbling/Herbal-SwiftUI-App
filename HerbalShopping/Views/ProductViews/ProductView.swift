
import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cart: CartViewModel
    @Environment(\.presentationMode) var presentation
    @State private var quantity: Int = 1
    @State private var isPressed = false
    
    let product: Product
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                HStack{
                    Button(action:{presentation.wrappedValue.dismiss()}){
                        Image(systemName: "xmark")
                            .padding(8)
                            .background(Color.secondaryBackground)
                            .clipShape(Circle())
                    }
                    Spacer()
                }.padding()
                ProductImage(imageName: product.title).padding(.top)
                    .environmentObject(cart)
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.bottom)
                        .cornerRadius(25)
                        .shadow(color: .accentColor.opacity(0.2), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    VStack(spacing: 0){
                        Text(product.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.top,24)
                            .padding(.bottom,4)
                        Text("\(product.price.format(f: ".02"))¥/kg")
                            .font(.headline)
                        .padding(4)
                        Text("库存：\(product.number)kg")
                            .font(.headline)
                        .padding(4)
                        HStack(spacing: 2) {
                            Text("\(product.formatedRating)").font(.title3)
                            Text("(\(product.manualCount))").font(.caption)
                                .foregroundColor(.secondary)
                                .offset(y: 3)
                        }
                        .padding(4)
                        ScrollView{
                            Text(product.discription)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        VStack(spacing: 0) {
                            Text("Quantity").font(.headline)
                            Picker(selection: $quantity, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                                ForEach(1...10, id:\.self){quantity in
                                    Text("\(quantity)").tag(quantity)
                                }
                                
                            }).pickerStyle(SegmentedPickerStyle())
                            .padding()
                        }
                        Button(action: {
                            self.isPressed = true
                            cart.addToCart(addedProduct: product, quantity: quantity)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 延迟1秒
                                self.isPressed = false
                            }
                        }){
                            HStack {
                                Text("加入购物车").bold()
                            }
                        }.buttonStyle(AddCartButtonStyle(isPressed: $isPressed))
                    }
                }.edgesIgnoringSafeArea(.bottom)
                Spacer()
            }
        }.navigationBarTitleDisplayMode(.large)
            }
}

struct ProductImage: View {
    @EnvironmentObject var cart: CartViewModel
    let imageName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 360, height: 200, alignment: .center)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        if let image = UIImage(named: imageName) {
                            HStack {
                                Spacer()
                                Image(uiImage: image)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        } else {
                            ProgressView()
                        }
                    }
                )
        }
        .cornerRadius(12)
    }
}
