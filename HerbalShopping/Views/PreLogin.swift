import SwiftUI

struct PreLogin: View {
    @StateObject var userVM = UserViewModel()
    var body: some View {
        ZStack {
            VStack{
                if let user = userVM.user{
                    MainView(user_info:user).environmentObject(userVM)
                } else {
                    LoginView().environmentObject(userVM)
                }
            }
            }
        }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        PreLogin()
            .environmentObject(UserViewModel())
    }
}
