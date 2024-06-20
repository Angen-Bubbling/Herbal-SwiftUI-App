import SwiftUI

struct HomeView: View {
    @ObservedObject var productsList: ProductsListObject
    @EnvironmentObject var cart: CartViewModel
    @ObservedObject var user: UserViewModel
    @State var pickedCategory: ProductListEndpoint = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("你好 \(user.user?.name ?? "")! \n 欢迎来到中药商城🥳")
                            .font(.title).bold()
                            .foregroundColor(.darkText)
                            .multilineTextAlignment(.center)
                            .padding()
                        CustomPicker(choosenCategory: $pickedCategory)
                            .onChange(of: pickedCategory, perform: { value in
                                    productsList.loadProducts(with: pickedCategory)
                            })
                        if productsList.products != nil {
                            ProductList(products: productsList.products!)
                                .environmentObject(cart)
                        }
                    }
                    .onAppear{
                            productsList.loadProducts(with: pickedCategory)
                    }
                    Spacer(minLength: 40)
                }
            }.navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                leading:
                    leadingBarItem()
            )
        }.statusBar(hidden: true)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: ProductsListObject(), user: UserViewModel()).environmentObject(CartViewModel())
    }
}



struct leadingBarItem: View {
    var body: some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.darkText)
                .imageScale(.large)
                .padding()
        }
        .navigationBarHidden(true)
    }
}

