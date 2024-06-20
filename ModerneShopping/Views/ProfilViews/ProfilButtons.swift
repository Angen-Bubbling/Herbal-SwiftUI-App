
import SwiftUI

struct ProfilButtons: View {
    @EnvironmentObject var user: UserViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: HistoryView()
            ){
                HStack {
                    Text("历史记录")
                    Image(systemName: "cart.fill")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
            Button(action:{withAnimation{user.signout()}}){
                HStack {
                    Text("退出登录")
                    Image(systemName: "person.crop.circle.fill.badge.xmark")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
        }.padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfilButtons_Previews: PreviewProvider {
    static var previews: some View {
        ProfilButtons()
    }
}

