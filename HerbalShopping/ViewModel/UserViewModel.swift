
import SwiftUI

class  UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var isLoggedin = false
    @Published var login = ""
    @Published var password = ""
    @Published var isNameValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    
    private let userServices: DataBaseServiceProtocol
    
    init(userServices: DataBaseServiceProtocol = DatabaseService.shared){
        self.userServices = userServices
    }
    
    func createUser(email: String, username: String, password: String) {
        print("Creating user with email: \(email), username: \(username), and password: \(password)")
        self.login = username
        self.password = password
        userServices.addUser(name: username, email: email, password: password)
    }
    
    func signout(){
        isLoading = true
        isNameValid = nil
        isPasswordValid = nil
                self.user = nil
        self.isLoading = false
    }
    
    func validateNameAndPassword(username: String, password: String) {
            DatabaseService.shared.fetchUserByUsername(username: username) { result in
                switch result {
                case .success(let user):
                    if let user = user, user.password == password {
                        self.isNameValid = true
                        self.isPasswordValid = true
                        self.user = user
                        print("User found and password is correct: \(user.name ?? "")")
                    } else {
                        self.isNameValid = user != nil
                        self.isPasswordValid = false
                        print("User found but password is incorrect:") /*\(user?.name ?? "") \(user?.password ?? "")")*/
                    }
                case .failure(let error):
                    self.isNameValid = false
                    self.isPasswordValid = false
                    print("Error fetching user: \(error)")
                }
            }
        }

}


