//
//  CartListItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListItem: View {
    @ObservedObject var cart: CartViewModel
    let product: Product
    @State var quantity: Int = 0
    var body: some View {
        HStack(spacing: 16) {
            SmallCartListItemImage(imageName: product.title)
            VStack {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("\((product.price * Double(quantity)).format(f: ".2")) ¥")
            }
            Spacer()
            Picker(selection: $quantity, label: Text("Picker"), content: {
                ForEach(1...100, id:\.self){quantity in
                    Text("\(quantity)")
                        .tag(quantity)
                }.onChange(of: quantity, perform: { value in
                    cart.changeQuantity(product: product, quantity: quantity)
                })
            })
            .pickerStyle(WheelPickerStyle())
            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipped()
            .padding(.trailing)
        }
        .padding(.vertical)
        .padding(.leading, 8)
        .background(Color.background)
        .onAppear{
            if let quantity = cart.cartProductDic[product]{
                self.quantity = quantity
            }
        }
    }
}

struct SmallCartListItemImage: View {
    let imageName: String
    
    var body: some View {
        ZStack{
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
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

