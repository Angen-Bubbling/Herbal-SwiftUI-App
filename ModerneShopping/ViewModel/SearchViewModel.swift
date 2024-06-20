
import Foundation

class SearchViewModel:ObservableObject{
    @Published var searchText = ""
    @Published var products: [Product]?
    @Published var error: NSError?
    
    private let searchListService: DataBaseServiceProtocol
    
    init(searchService: DataBaseServiceProtocol = DatabaseService.shared){
        self.searchListService = searchService
    }
    
    func LoadSearch(with SearchInfo: String){
        self.products = nil
        searchListService.fetchProductsByNameOrCategory(searchText: SearchInfo)
        {
            (result) in
            switch result {
            case .success(let response):
                    self.products = response
            case .failure(let error):
                    self.error = error as NSError
            }
         }
    }
}
    
