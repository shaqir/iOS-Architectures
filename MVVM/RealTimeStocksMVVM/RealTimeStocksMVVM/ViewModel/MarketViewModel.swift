//
//  MarketViewModel.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI
import Combine

class MarketViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var allStocks: [StockViewData] = []
    @Published var filteredStocks: [StockViewData] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: MarketUseCase
    
    init(useCase: MarketUseCase = MarketInteractor(service: MarketDataService())) {
        self.useCase = useCase
        bind()
        useCase.start()
    }
    
    private func bind() {
        useCase.publisher
            .receive(on: RunLoop.main)
            .sink { [weak self] stocks in
                self?.allStocks = stocks
            }
            .store(in: &cancellables)
        
        $searchText
            .combineLatest($allStocks)
            .map { text, stocks in
                text.isEmpty ? stocks : stocks.filter { $0.symbol.contains(text.uppercased()) }
            }
            .assign(to: &$filteredStocks)
    }
    
    deinit {
        useCase.stop()
    }
}
