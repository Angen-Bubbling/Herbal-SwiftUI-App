//
//  UserViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

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
    
    /// Calling the API Service VM Getting a user through random generated user API
//    func loadUser(){
//        // setting the user to nil to load a fresh one
//        self.user = nil
//        // showing the spining loading view, using the main thread for UI Work
//        DispatchQueue.main.async {
//            self.isLoading = true
//        }
//        // calling the api function and assigning the user if found
//        userServices.fetchUser { (result) in
//            DispatchQueue.main.async {
//                self.isLoading = true
//            }
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    self.user? = response[0]
//                    //self.isLoading = false
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    print(error)
//                    self.error = error as NSError
//                }
//            }
//        }
//    }
//    
    func createUser(email: String, username: String, password: String) {
        print("Creating user with email: \(email), username: \(username), and password: \(password)")
        self.login = username
        self.password = password
        userServices.addUser(name: username, email: email, password: password)
    }
    
    /// signing out and reseting the login view
    func signout(){
        isLoading = true
        isNameValid = nil
        isPasswordValid = nil
        // Delaying the logout to see the Loading animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.user = nil
            self.isLoading = false
        }
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


//func validateName(name: String){
//    guard name.count > 5 && name.count < 24 else {
//        withAnimation{
//            isNameValid = false
//        }
//        return
//    }
//    guard name.contains("@") else {
//        withAnimation{
//            isNameValid = false
//        }
//        return
//    }
//    withAnimation{
//        isNameValid = true
//    }
//}
///// validate if the password respect our conditions
///// - Parameter name: password
//func validatePassword(name: String){
//    guard name.count >= 5 && name.count < 24 else {
//        withAnimation{
//            isPasswordValid = false
//        }
//        return
//    }
//    withAnimation{
//        isPasswordValid = true
//    }
//}
//}
