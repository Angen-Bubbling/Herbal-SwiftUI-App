//
//  CartLoadingView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI

struct CartLoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack {
                CartLoading()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Your cart is empty").font(.headline)
            }
            Spacer()
        }
    }
}

