//
//  ProductListItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct ProductListItem: View {
    let product: Product
    var body: some View {
        VStack {
            SmallProductImage(imageName: product.title)
            Text(product.title)
                .foregroundColor(.darkText)
                .bold()
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text("\(product.price.format(f: ".2"))¥/kg").bold()
                .foregroundColor(.darkText)
            HStack(spacing: 2) {
                Text("\(product.formatedRating)").font(.title3)
                    .foregroundColor(.darkText)
                Text("(\(product.manualCount))").font(.caption2)
                    .foregroundColor(.secondary)
                    .offset(y: 3)
                }
        }.padding(8)
    }
}


struct SmallProductImage: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 170, height: 190, alignment: .center)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        if let image = UIImage(named: imageName) {
                            HStack {
                                Spacer()
                                Image(uiImage: image)
                                    .resizable()
                                    .compositingGroup()
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        } else {
                            ProgressView()
                        }
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
    }
}

