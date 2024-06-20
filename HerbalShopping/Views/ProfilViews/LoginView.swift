
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var isNameValid: Bool? = nil
    @State private var isPasswordValid: Bool? = nil
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        ZStack{
            Color.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center,spacing: 16){
                Text("登录")
                    .font(.title3).bold()
                LoginLottieView()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                VStack{
                    HStack {
                        LoginTextView(name: $user.login, isValid: $user.isNameValid)
                        if let nameValid = user.isNameValid{
                            if nameValid {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .padding(8)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .padding(8)
                            }
                        }
                    }
                    HStack {
                        PasswordTextView(name: $user.password, isValid: $user.isPasswordValid, showPassword: $showPassword)
                        if let passwordValid = user.isPasswordValid{
                            if passwordValid {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .padding(8)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .padding(8)
                            }
                        }
                    }
                    Button(action: {
                        user.validateNameAndPassword(username: user.login,password:user.password)
                            if user.isNameValid == true &&
                                user.isPasswordValid == true {
                                withAnimation{
                                    //成功登录
                                }
                            } else {
                                withAnimation{
                                    user.isNameValid = nil
                                    user.isPasswordValid = nil
                                }
                            }
                    }){
                        Text("登录")
                            .foregroundColor(.darkText)
                            .font(.headline)
                            .padding()
                            .background(Color.secondaryBackground)
                            .cornerRadius(16)
                            .shadow(color: .darkText.opacity(0.2), radius: 2, x: 1.0, y: 2)
                    }
                    Button(action:{withAnimation{
                        showSheet.toggle()
                    }}){
                        Text("创建账户").font(.headline)
                            .foregroundColor(.darkText)
                            .shadow(color: .darkText.opacity(0.1), radius: 2, x: 1, y: 2)
                    }
                }
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(16)
                Spacer()
            }.padding()
            .sheet(isPresented: $showSheet){
                VStack {
                    Text("创建账户")
                        .font(.headline)
                        .padding(.bottom, 20)
                    
                    TextField("邮箱", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                    
                    TextField("用户名", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                    
                    TextField("密码", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                    
                    Button(action: {
                                user.createUser(email: email, username: username, password: password)
                                print("创建用户，邮箱: \(email) 和用户名: \(username)")
                                showSheet = false
                                    })
                                    {
                                        Text("创建用户")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.secondaryBackground)
                                            .cornerRadius(8)
                                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
    }
}

struct LoginTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    var body: some View {
        HStack {
            TextField("用户名",text: $name)
                .padding()
                .background(Color.background)
                .cornerRadius(16)
                .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }

}

struct PasswordTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    @Binding var showPassword: Bool
    var body: some View {
        Group{
            if !showPassword{
                HStack {
                    SecureField("密码",text: $name)
                        .padding()
                        .background(Color.background)
                        .cornerRadius(16)
                        .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action:{
                        withAnimation{
                            showPassword.toggle()
                        }
                    }){
                        Image(systemName: "eye")
                            .imageScale(.large)
                    }
                }
            } else {
                HStack {
                    LoginTextView(name: $name,isValid: $isValid)
                    Button(action:{showPassword.toggle()}){
                        Image(systemName: "eye.slash")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

