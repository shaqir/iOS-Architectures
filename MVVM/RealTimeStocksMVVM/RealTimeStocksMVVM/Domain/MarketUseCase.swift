//
//  MarketInteractor.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI
import Combine
// MARK: - Use Case

protocol MarketUseCase {
    var publisher: AnyPublisher<[StockViewData], Never> { get }
    func start()
    func stop()
}

class MarketInteractor: MarketUseCase {
    private let service: MarketDataProviding
    private var cancellables = Set<AnyCancellable>()
    private let output = PassthroughSubject<[StockViewData], Never>()
    
    var publisher: AnyPublisher<[StockViewData], Never> {
        output.eraseToAnyPublisher()
    }
    
    init(service: MarketDataProviding) {
        self.service = service
    }
    
    func start() {
        service.connect()
        service.tickerStream
            .throttle(for: .milliseconds(1000), scheduler: RunLoop.main, latest: true)
            .map { $0.map(StockViewData.init) }
            .sink { [weak self] in self?.output.send($0) }
            .store(in: &cancellables)
    }
    
    func stop() {
        service.disconnect()
        cancellables.removeAll()
    }
}

