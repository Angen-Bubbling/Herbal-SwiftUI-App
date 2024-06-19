//
//  DataBaseService.swift
//  ModerneShopping
//
//  Created by 张真瑜 on 2024/6/14.
//

import CoreData

enum ProductListEndpoint: String, CaseIterable {
    
    case all = "所有类别"
    case root = "根及根茎类"
    case seed = "果实种子类"
    case flower = "花类"
    case leaf = "叶类"
    case wholeHerb = "全草类"
    case barkResin = "皮类树脂类"
    case stemWood = "茎木类"
    case fungiAlgae = "菌藻类"
    
    var description: String {
        switch self {
        case .all: return "all"
        case .root: return "根及根茎类"
        case .seed: return "果实种子类"
        case .flower: return "花类"
        case .leaf: return "叶类"
        case .wholeHerb: return "全草类"
        case .barkResin: return "皮类树脂类"
        case .stemWood: return "茎木类"
        case .fungiAlgae: return "菌藻类"
        }
    }
}




protocol DataBaseServiceProtocol {
    func fetchProductsByCategory(category:String ,completion: @escaping (Result<[Product], Error>) -> ())
    func fetchUser(completion: @escaping (Result<[User], Error>) -> ())
    func addUser(name: String?, email: String?, password: String?)
    func fetchUserByUsername(username: String, completion: @escaping (Result<User?, Error>) -> ())
    func fetchProductsByNameOrCategory(searchText: String, completion: @escaping (Result<[Product], Error>) -> ())
}


class DatabaseService : DataBaseServiceProtocol {
    static let shared = DatabaseService()
    private let context = CoreDataStack.shared.context
    private init(){
        if(isCoreDataEmpty())
        {
            addProduct(title:"黄芪",price:22.00,discription:"黄芪，又称北芪，亦作黄耆，常用中药之一。主产于中国大陆的内蒙古、山西、黑龙江等地。春秋两季采挖，除去须根及根头，晒干，切片，生用或蜜炙用",category:"根及根茎类",number:100,rate:3.5);
            addProduct(title:"三七",price:240.00,discription:"三七又称三七草、三七仔、参漆草、参三七、田七、土三七、血山草、六月淋、蝎子草、山漆、田漆，为五加科人参属的物种，是云南白药的主要成分。主产地在中国的云南文山及广西深山中。三七的三条枝上各生七片叶，因而得名；也有人说，它在种植后，三至七年收获而得名。",category:"根及根茎类",number:100,rate:3.5);
            addProduct(title:"百合",price:85.00,discription:"百合，中药名。为百合科植物卷丹或细叶百合的干燥肉质鳞叶。具有养阴润肺，清心安神之功效。百合常用于治疗阴虚燥咳，劳嗽咳血，虚烦惊悸，失眠多梦，精神恍惚。",category:"根及根茎类",number:100,rate:3.5);

            addProduct(title:"枸杞子",price:56.00,discription:"枸杞子，中药材名，功能主治为滋肾，润肺，补肝，明目。治肝肾阴亏，腰膝酸软，头晕，目眩，目昏多泪，虚劳咳嗽，消渴，遗精。",category:"果实种子类",number:100,rate:3.5);
            addProduct(title:"莲子",price:35.00,discription:"莲子，中药名。为睡莲科植物莲的干燥成熟种子。分布于中国南北各省。具有补脾止泻，止带，益肾涩精，养心安神之功效。常用于脾虚泄泻，带下，遗精，心悸失眠。",category:"果实种子类",number:100,rate:3.5);
            addProduct(title:"金樱子",price:16.00,discription:"金樱子，中药名。为蔷薇科植物金樱子的干燥成熟果实。分布于陕西、安徽、江西、江苏、浙江、湖北、湖南、广东、广西、台湾、福建、四川、云南、贵州等地。具有固精缩尿，固崩止带，涩肠止泻之功效。常用于遗精滑精，遗尿尿频，崩漏带下，久泻久痢",category:"果实种子类",number:100,rate:3.5);


            addProduct(title:"山银花",price:50.00,discription:"山银花，中药材名。本品为忍冬科植物灰毡毛忍冬、红腺忍冬、华南忍冬、成黄褐毛忍冬的干燥花蕾或带初开的花。夏初花开放前采收，于燥。功能主治为：清热解毒，疏散风热。用于痈肿疗疮，喉痹，丹毒，热毒血痢，风热感冒，温病发热。",category:"花类",number:100,rate:3.5);
            addProduct(title:"野菊花",price:42.00,discription:"野菊花，中药名。别名：野黄菊花、苦薏 、山菊花、甘菊花。为菊科多年生草本植物，野菊花头状花序的外形与菊花相似，野生于山坡草地、田边、路旁等野生地带。以色黄无梗、完整、苦辛、花未全开者为佳。野菊花性微寒，具疏散风热、消肿解毒。能治疗疔疮痈肿、咽喉肿痛、风火赤眼、头痛眩晕等病证。",category:"花类",number:100,rate:3.5);
            addProduct(title:"红花",price:115.00,discription:"红花，中药名。为菊科植物红花.的干燥花。夏季花由黄变红时采摘，阴干或晒干。全国各地广有栽培。具有活血通经，散瘀止痛之功效。用于经闭，痛经，恶露不行，症瘕痞块，胸痹心痛，瘀滞腹痛，胸胁刺痛，跌扑损伤，疮疡肿痛。",category:"花类",number:100,rate:3.5);

        }
    }
    
    func fetchProductsByNameOrCategory(searchText: String, completion: @escaping (Result<[Product], Error>) -> ()) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        // Fetch products by name or category
        let namePredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let categoryPredicate = NSPredicate(format: "category CONTAINS[cd] %@", searchText)
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, categoryPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let products = try context.fetch(fetchRequest)
            completion(.success(products))
        } catch {
            completion(.failure(error))
        }
    }

    
    func fetchProductsByCategory(category:String,completion: @escaping (Result<[Product], Error>) -> ()) {
        if category == "all" {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            do {
                let products = try context.fetch(fetchRequest)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
        else{
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
            do {
                let products = try context.fetch(fetchRequest)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
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
    
    func addProduct(title: String, price: Double, discription: String,category:String,number:Int32,rate:Double) {
        let newProduct = Product(context: context)
        newProduct.title = title
        newProduct.price = price
        newProduct.discription = discription
        newProduct.category = category
        newProduct.number = number
        newProduct.rate = rate
        
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
    
    func fetchProductsByHistory(for history: History) -> [Product] {
        let products = history.productArray
        return products
    }

}
