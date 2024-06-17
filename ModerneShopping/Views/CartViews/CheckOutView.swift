//
//  CheckOutView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-07.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var cart: CartViewModel
    @State private var showSuccessAlert = false

    let products: [Product]
    let price:Double
    
    var body: some View {
        VStack {
            Spacer()
            if !showSuccessAlert{
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.bottom)
                    Color.secondaryBackground.opacity(0.3).edgesIgnoringSafeArea(.bottom)
                    
                    VStack(alignment: .center, spacing: 16) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    cart.showShowcaseSheet.toggle()
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.darkText)
                            }
                            .buttonStyle(.borderless)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        ForEach(products) { product in
                            HStack {
                                Text(product.title)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                Text("\(product.price.format(f: ".2"))¥")
                                    .bold()
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .foregroundColor(.darkText)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                        
                        VStack(spacing: 8) {
                            Text("总价：\((price).format(f: ".2"))¥")
                                .font(.subheadline)
                        }
                        
                        Button(action: {
                            cart.emptyAndStoreCart()
                            showSuccessAlert = true;
                        }) {
                            Text("点击付款")
                                .bold()
                                .padding()
                                .background(Color.secondaryBackground)
                                .cornerRadius(18)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding(.bottom, 16)
                        Spacer()
                            .foregroundColor(.darkText)
                        Spacer()
                    }
                }
                .cornerRadius(12)
                .frame(height: 400)
                .padding(.horizontal, 16)
            }
        }
        .transition(.move(edge: .bottom))
        .zIndex(20)
        .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("购买成功"),
                        message: Text("感谢您的购买！"),
                        dismissButton: .default(Text("确定")){
                            showSuccessAlert = false
                            cart.showShowcaseSheet = false

                        }
                    )
                }
    }

}
