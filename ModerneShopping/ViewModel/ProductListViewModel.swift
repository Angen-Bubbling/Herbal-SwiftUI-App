
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
        DispatchQueue.main.async {
            self.isLoading = true
        }
        productListServices.fetchProductsByCategory(category: ProductCategory.description) { (result) in
            DispatchQueue.main.async {
                self.isLoading = true
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error as NSError
                    print(error.localizedDescription)
                }
            }
        }
    }
}
