//
//  SearchView.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/16.
//

import SwiftUI

struct SearchView: View {
    @StateObject var search = SearchViewModel()
    @EnvironmentObject var cart: CartViewModel
    
    var body: some View {
        ScrollView(.vertical){
            Text("搜索药品或类别")
                .font(.title).bold()
                .foregroundColor(.darkText)
                .multilineTextAlignment(.center)
                .padding()
            VStack {
                HStack {
                    TextField("", text: $search.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical,10)
                        .padding(.horizontal,20)
                        .cornerRadius(10)
                        .frame(height: 70)
                        .font(.headline)
                        .cornerRadius(10)
                        .padding(.leading, 10)
                    Button(action: {
                        search.LoadSearch(with: search.searchText)
                    }) {
                        Text("搜索")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color("darkText"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.trailing, 20)
                }
                .background(Color.secondaryBackground)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top,0)
                Spacer()
                if search.products != nil{
                    ProductList(products: search.products!)
                        .environmentObject(cart)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
