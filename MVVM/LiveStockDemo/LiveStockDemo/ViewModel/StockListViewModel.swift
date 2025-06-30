//
//  StockListViewModel.swift
//  LiveStockDemo
//
//  Created by Sakir Saiyed on 2025-06-29.
//

import Foundation
import Combine

final class StockListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []

    private let service: StockStreamingService
    private var cancellables = Set<AnyCancellable>()

    init(service: StockStreamingService = MockStockStreamingService()) {
        self.service = service
        bind()
    }

    private func bind() {
        service.stockPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedStocks in
                self?.stocks = updatedStocks
            }
            .store(in: &cancellables)
    }
}
