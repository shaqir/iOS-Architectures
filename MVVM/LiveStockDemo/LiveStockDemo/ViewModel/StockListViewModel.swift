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
    
    //Tracks Combine subscriptions for memory safety.
    private var cancellables = Set<AnyCancellable>()

    init(service: StockStreamingService = MockStockStreamingService()) {
        self.service = service
        bind()
    }
    
    //binds to the stock stream.
    private func bind() {
        //Subscribes to the publisher from the service.
        service.stockPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedStocks in
                self?.stocks = updatedStocks//Updates the stocks property with each emission.
            }
            .store(in: &cancellables)//Stores the subscription in cancellables.
    }
}
