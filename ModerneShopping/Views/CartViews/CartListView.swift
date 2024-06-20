//
//  CartListView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListView: View {
    @ObservedObject var cart: CartViewModel
    let products: [Product: Int] 
    @Binding var showDelete: Bool
    
    var body: some View {
        let productsDic = products.map({ $0.key })
        List {
            ForEach(productsDic, id: \.self) { key in
                if #available(iOS 15.0, *) {
                    ZStack {
                        CartListItem(cart: cart, product: key, quantity: products[key] ?? 0)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            cart.removeFromCart(toRemove: key)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .onTapGesture {
                        showDelete.toggle()
                    }
                } else {
                    ZStack {
                        HStack {
                            Spacer()
                            if showDelete {
                                Button(action: {
                                    withAnimation {
                                        cart.removeFromCart(toRemove: key)
                                    }
                                }) {
                                    HStack {
                                        VStack {
                                            Spacer()
                                            Image(systemName: "xmark")
                                                .imageScale(.large)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        .frame(width: 100)
                                        .background(Color.red)
                                        .frame(width: 100)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        CartListItem(cart: cart, product: key, quantity: products[key] ?? 0)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .offset(x: showDelete ? 100 : 0)
                    }
                }
            }
        }
    }
}
