
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
            addProduct(title: "黄芪", price: 22.00, discription: "黄芪，又称北芪，亦作黄耆，常用中药之一。主产于中国大陆的内蒙古、山西、黑龙江等地。春秋两季采挖，除去须根及根头，晒干，切片，生用或蜜炙用", category: "根及根茎类", number: 87, rate: 4.3);

            addProduct(title: "三七", price: 240.00, discription: "三七又称三七草、三七仔、参漆草、参三七、田七、土三七、血山草、六月淋、蝎子草、山漆、田漆，为五加科人参属的物种，是云南白药的主要成分。主产地在中国的云南文山及广西深山中。三七的三条枝上各生七片叶，因而得名；也有人说，它在种植后，三至七年收获而得名。", category: "根及根茎类", number: 54, rate: 4.1);

            addProduct(title: "百合", price: 85.00, discription: "百合，中药名。为百合科植物卷丹或细叶百合的干燥肉质鳞叶。具有养阴润肺，清心安神之功效。百合常用于治疗阴虚燥咳，劳嗽咳血，虚烦惊悸，失眠多梦，精神恍惚。", category: "根及根茎类", number: 32, rate: 4.0);

            addProduct(title: "枸杞子", price: 56.00, discription: "枸杞子，中药材名，功能主治为滋肾，润肺，补肝，明目。治肝肾阴亏，腰膝酸软，头晕，目眩，目昏多泪，虚劳咳嗽，消渴，遗精。", category: "果实种子类", number: 68, rate: 4.2);

            addProduct(title: "莲子", price: 35.00, discription: "莲子，中药名。为睡莲科植物莲的干燥成熟种子。分布于中国南北各省。具有补脾止泻，止带，益肾涩精，养心安神之功效。常用于脾虚泄泻，带下，遗精，心悸失眠。", category: "果实种子类", number: 79, rate: 4.1);

            addProduct(title: "金樱子", price: 16.00, discription: "金樱子，中药名。为蔷薇科植物金樱子的干燥成熟果实。分布于陕西、安徽、江西、江苏、浙江、湖北、湖南、广东、广西、台湾、福建、四川、云南、贵州等地。具有固精缩尿，固崩止带，涩肠止泻之功效。常用于遗精滑精，遗尿尿频，崩漏带下，久泻久痢", category: "果实种子类", number: 61, rate: 4.0);

            addProduct(title: "山银花", price: 50.00, discription: "山银花，中药材名。本品为忍冬科植物灰毡毛忍冬、红腺忍冬、华南忍冬、成黄褐毛忍冬的干燥花蕾或带初开的花。夏初花开放前采收，于燥。功能主治为：清热解毒，疏散风热。用于痈肿疗疮，喉痹，丹毒，热毒血痢，风热感冒，温病发热。", category: "花类", number: 74, rate: 4.4);

            addProduct(title: "野菊花", price: 42.00, discription: "野菊花，中药名。别名：野黄菊花、苦薏 、山菊花、甘菊花。为菊科多年生草本植物，野菊花头状花序的外形与菊花相似，野生于山坡草地、田边、路旁等野生地带。以色黄无梗、完整、苦辛、花未全开者为佳。野菊花性微寒，具疏散风热、消肿解毒。能治疗疔疮痈肿、咽喉肿痛、风火赤眼、头痛眩晕等病证。", category: "花类", number: 58, rate: 4.3);

            addProduct(title: "红花", price: 115.00, discription: "红花，中药名。为菊科植物红花.的干燥花。夏季花由黄变红时采摘，阴干或晒干。全国各地广有栽培。具有活血通经，散瘀止痛之功效。用于经闭，痛经，恶露不行，症瘕痞块，胸痹心痛，瘀滞腹痛，胸胁刺痛，跌扑损伤，疮疡肿痛。", category: "花类", number: 45, rate: 4.5);

            addProduct(title: "紫苏叶", price: 30.00, discription: "紫苏叶，中药名。紫苏的茎、叶和种子均可入药，其叶又称苏叶，具有解表散寒、行气和胃功效；其果实紫苏子又名苏子、黑苏子、野麻子、铁苏子，具有降气消痰、平喘、润肠功效；紫苏梗有理气宽中、止痛、安胎功效。", category: "叶类", number: 41, rate: 4.1);

            addProduct(title: "淫羊藿", price: 75.00, discription: "淫羊藿，中药名。淫羊藿又名仙灵脾、刚前，《神农本草经》列为中品，具有补肾阳、强筋骨、祛风湿功效，用于肾阳虚衰所致阳痿遗精、筋骨痿软、风湿痹痛、麻木拘挛，是临床常用中药。中国是淫羊藿的地理分布中心，有40个淫羊藿品种，形成药材商品的主要种类有15种，其中淫羊藿、柔毛淫羊藿、箭叶淫羊藿和朝鲜淫羊藿被2015年版《中华人民共和国药典》收载为主要基原种。", category: "叶类", number: 53, rate: 4.2);

            addProduct(title: "荷叶", price: 28.00, discription: "荷叶，中药名。莲科莲属多年生草本挺水植物。荷花一般长到150厘米高，横向扩展到3米。荷叶最大可达直径60厘米，莲花最大直径可达20厘米。荷花有许多不同的栽培品种，花色从雪白、黄色到淡红色及深黄色和深红色，其外还有分洒锦等等花色。广布于南北各地。主要有清热解暑，升发清阳，散瘀止血的功效。", category: "叶类", number: 47, rate: 4.0);

            addProduct(title: "肉苁蓉", price: 180.00, discription: "肉苁蓉，中药材名。本品为列当科植物肉苁蓉或苁蓉、迷肉苁蓉等的肉质茎。春、秋均可采收。但以3～5月间采者为好，过时则中空。春季采者，通常半埋于沙土中晒干，商品称为甜大芸、淡大芸或淡苁蓉。秋采者，因水分多，不易晒干，须投入盐湖中1～3年后，取出晒干，称为盐大芸、咸大芸或咸苁蓉。功能主治为：补肾，益精，润燥，滑肠。治男子阳痿，女子不孕，带下，血崩，腰膝冷痛，血枯便秘。", category: "全草类", number: 51, rate: 4.3);

            addProduct(title: "石斛", price: 95.00, discription: "石斛，中药名。为兰科植物金钗石斛、鼓槌石斛或流苏石斛的栽培品及其同属植物近似种的新鲜或干燥茎。具有益胃生津，滋阴清热之功效。常用于热病津伤，口干烦渴，胃阴不足，食少干呕，病后虚热不退，阴虚火旺，骨蒸劳热，目暗不明，筋骨痿软。", category: "全草类", number: 39, rate: 4.1);

            addProduct(title: "鸡骨草", price: 60.00, discription: "鸡骨草，中药名。为豆科植物广州相思子的干燥全株。甘、微苦，凉。有利湿退黄，清热解毒，疏肝止痛之功效。常用于湿热黄疸，胁肋不舒，胃脘胀痛，乳痈肿痛。鸡骨草还可在春夏潮湿季节用来煲汤作食疗。", category: "全草类", number: 44, rate: 4.0);

            addProduct(title: "杜仲", price: 70.00, discription: "杜仲，中药材名。本品为杜仲科植物杜仲的树皮。为了保护资源，一般采用局部剥皮法。在清明至夏至间，选取生长15～20年以上的植株，按药材规格大小，剥下树皮，刨去粗皮，晒干。置通风干燥处。功能主治为：补肝肾，强筋骨，安胎。治腰脊酸疼，足膝痿弱，小便余沥，阴下湿痒，胎漏欲堕，胎动不安，高血压。", category: "皮类树脂类", number: 56, rate: 4.2);

            addProduct(title: "厚朴", price: 45.00, discription: "厚朴，中药名。为木兰科植物厚朴或凹叶厚朴的干燥干皮、根皮及枝皮。4～6月剥取，根皮和枝皮直接阴干；干皮置沸水中微煮后，堆置阴湿处，“发汗”至内表面变紫褐色或棕褐色时，蒸软，取出，卷成筒状，干燥。", category: "皮类树脂类", number: 50, rate: 4.0);

            addProduct(title: "黄柏", price: 40.00, discription: "黄柏，中药名。为芸香科植物黄皮树的干燥树皮。习称“川黄柏”。剥取树皮后，除去粗皮，晒干。", category: "皮类树脂类", number: 52, rate: 4.1);

            addProduct(title: "钩藤", price: 35.00, discription: "钩藤，中药名。为茜草科植物钩藤、大叶钩藤、毛钩藤、华钩藤或无柄果钩藤的干燥带钩茎枝。具有息风定惊，清热平肝之功效。常用于肝风内动，惊痫抽搐，高热惊厥，感冒夹惊，小儿惊啼，妊娠子痫，头痛眩晕。", category: "茎木类", number: 49, rate: 4.2);

            addProduct(title: "鸡血藤", price: 38.00, discription: "鸡血藤，中药名。为豆科植物密花豆的干燥藤茎。秋、冬二季采收，除去枝叶，切片，晒干。分布于广东、广西、云南等地。具有活血补血，调经止痛，舒筋活络之功效。用于风湿痹痛，麻木瘫痪，血虚萎黄，月经不调，痛经，经闭和妇科疾病也有较好疗效。", category: "茎木类", number: 47, rate: 4.1);

            addProduct(title: "桂枝", price: 25.00, discription: "桂枝，中药名。属樟目，樟科中等大乔木；一年生枝条圆柱形，顶芽芽鳞宽卵形，绿色的叶子互生，长椭圆形至近披针形；花白色，长约4.5mm；果椭圆形，成熟时黑紫色，无毛；花期6～8月，果期10～12月。主产于广西、广东及云南等地。春、夏季剪下嫩枝，晒干或阴干，切成薄片或小段用。辛、甘，温。归心、肺、膀胱经。具有发汗解肌，温通经脉，助阳化气，平冲降气的功效。常用于风寒感冒，脘腹冷痛，血寒经闭，关节痹痛，痰饮，水肿，心悸等。", category: "茎木类", number: 61, rate: 4.0);

            addProduct(title: "茯苓", price: 60.00, discription: "茯苓，中药名。为多孔菌科真菌茯苓的干燥菌核。多于7～9月采挖，挖出后除去泥沙，堆置“发汗”后，摊开晾至表面干燥，再“发汗”，反复数次至现皱纹、内部水分大部散失后，阴干，称为“茯苓个”；或将鲜茯苓按不同部位切制，阴干，分别称为“茯苓块”和“茯苓片”。", category: "菌藻类", number: 55, rate: 4.1);

            addProduct(title: "茯神", price: 68.00, discription: "茯神，中药材名。本品为多孔菌科植物茯苓菌核中间天然抱有松根（即茯神木）的白色部分。功能主治为：宁心，安神，利水。治心虚惊悸，健忘，失眠，惊痫，小便不利。", category: "菌藻类", number: 53, rate: 4.2);

            addProduct(title: "灵芝", price: 120.00, discription: "灵芝，中药名。为多孔菌科真菌赤芝或紫芝的干燥子实体。具有补气安神，止咳平喘的功效。主治心神不宁，失眠，惊悸，咳喘痰多，虚劳证等。", category: "菌藻类", number: 42, rate: 4.3);


        }
    }
    
    func fetchProductsByNameOrCategory(searchText: String, completion: @escaping (Result<[Product], Error>) -> ()) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
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
