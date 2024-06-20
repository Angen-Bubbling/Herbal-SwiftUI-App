import Foundation

class  ProductsListObject: ObservableObject {
    @Published var products: [Product]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let productListServices: DataBaseServiceProtocol
    
    init(productServices: DataBaseServiceProtocol = DatabaseService.shared){
        self.productListServices = productServices
    }
    
    func loadProducts(with ProductCategory: ProductListEndpoint){
        self.products = nil
        self.isLoading = true
        productListServices.fetchProductsByCategory(category: ProductCategory.description) { (result) in
            self.isLoading = true
            switch result {
            case .success(let response):
                    self.products = response
                    self.isLoading = false
            case .failure(let error):
                    self.error = error as NSError
                    print(error.localizedDescription)
            }
        }
    }
}
