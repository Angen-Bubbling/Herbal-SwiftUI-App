//
//  ProfilView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-05.
//

import SwiftUI

struct PreLogin: View {
    @StateObject var userVM = UserViewModel()
    @StateObject var imageLoader = ImageLoader()
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
