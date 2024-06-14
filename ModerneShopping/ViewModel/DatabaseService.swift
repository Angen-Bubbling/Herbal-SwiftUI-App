//
//  DataBaseService.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/14.
//

import CoreData

enum ProductListEndpoint: String, CaseIterable {
    
    case all = "All"
    case jewelery = "Jewelery"
    case electronics = "electronics"
    case men = "men's clothing"
    case women = "women's clothing"
    
    var description: String {
        switch self {
        case .all: return "/"
        case .jewelery: return "/category/jewelery"
        case .electronics: return "/category/electronics"
        case .men: return "/category/men's%20clothing"
        case .women: return "/category/women's%20clothing"
        }
    }
}



protocol DataBaseServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> ())
    func fetchUser(completion: @escaping (Result<[User], Error>) -> ())
    func addUser(name: String?, email: String?, password: String?)
    func fetchUserByUsername(username: String, completion: @escaping (Result<User?, Error>) -> ())
}


class DatabaseService : DataBaseServiceProtocol {
    static let shared = DatabaseService()
    private let context = CoreDataStack.shared.context
    private init(){
        if(isCoreDataEmpty())
        {
            addProduct(id:1,title:"zhongyao1",price:3.0,discrip:"aba");
            addProduct(id:2,title:"zhongyao2",price:5.0,discrip:"aba");
            addProduct(id:3,title:"zhongyao3",price:6.0,discrip:"aba");
            addProduct(id:4,title:"zhongyao4",price:8.0,discrip:"aba");
        }
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let products = try context.fetch(fetchRequest)
            completion(.success(products))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchUserByUsername(username: String, completion: @escaping (Result<User?, Error>) -> ()) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", username)
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                completion(.success(user))
            } else {
                completion(.success(nil))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchUser(completion: @escaping (Result<[User], Error>) -> ()) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            completion(.success(users))
        } catch {
            completion(.failure(error))
        }
    }
    
    func isCoreDataEmpty() -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        fetchRequest.fetchLimit = 1
        do {
            let count = try context.count(for: fetchRequest)
            return count == 0
        } catch {
            print("Error fetching count: \(error)")
            return true
        }
    }
    
    func addProduct(id: Int32, title: String?, price: Double, discrip: String?) {
        let newProduct = Product(context: context)
        newProduct.id = id
        newProduct.title = title
        newProduct.price = price
        newProduct.discrip = discrip
        
        do {
            try context.save()
            print("Product added successfully!")
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addUser(name: String?, email: String?, password: String?) {
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password

        do {
            try context.save()
            print("User added successfully!")
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
