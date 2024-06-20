import SwiftUI

struct MainView: View {
    @EnvironmentObject var user: UserViewModel
    @StateObject var products = ProductsListObject()
    @StateObject var cartItems = CartViewModel()
    let user_info: User
    var body: some View {
        TabView{
            HomeView(productsList: products, user: user).environmentObject(cartItems)
                .tabItem {
                    Image(systemName:"house")
                    Text("主页")
                }
            CartView(cartProducts: cartItems)
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "cart")
                    Text("购物车")
                }
            LoggedInView(user: user_info)
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "person")
                    Text("账户")
                }
        }
        .zIndex(10)
    }
}
