
import SwiftUI

struct CartLoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack {
                CartLoading()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("购物车为空").font(.headline)
            }
            Spacer()
        }
    }
}

