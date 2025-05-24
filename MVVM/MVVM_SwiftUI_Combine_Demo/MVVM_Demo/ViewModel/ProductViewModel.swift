//
//  PostViewModel.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//
import Foundation
import Combine
import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchQuery = ""
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    private var currentPage = 0
    private let pageSize = 10
    private var isFetching = false
    private var hasMoreData = true

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        setupSearch()
        fetchProducts()
    }

    func fetchProducts(reset: Bool = false) {
        guard !isFetching && hasMoreData else { return }

        isFetching = true
        if reset {
            currentPage = 0
            hasMoreData = true
            products = []
        }

        let skip = currentPage * pageSize
        let endpoint: String

        if searchQuery.isEmpty {
            endpoint = "https://dummyjson.com/products?limit=\(pageSize)&skip=\(skip)"
        } else {
            endpoint = "https://dummyjson.com/products/search?q=\(searchQuery)&limit=\(pageSize)&skip=\(skip)"
        }

        apiService.fetch(endpoint)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isFetching = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] (response: ProductResponse) in
                self?.products += response.products
                self?.currentPage += 1
                self?.hasMoreData = self?.products.count ?? 0 < response.total
            }
            .store(in: &cancellables)
    }

    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                self?.fetchProducts(reset: true)
            }
            .store(in: &cancellables)
    }
}
