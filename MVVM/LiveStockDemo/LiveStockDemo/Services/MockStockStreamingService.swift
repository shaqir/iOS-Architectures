//
//  MockStockStreamingService.swift
//  LiveStockDemo
//
//  Created by Sakir Saiyed on 2025-06-29.
//
import Combine
import Foundation

protocol StockStreamingService {
    var stockPublisher: AnyPublisher<[Stock], Never> { get }
}

final class MockStockStreamingService: StockStreamingService {
    private var stocks: [Stock] = [
        Stock(symbol: "AAPL", price: 192.5, isPriceUp: true),
        Stock(symbol: "GOOGL", price: 2789.6, isPriceUp: true),
        Stock(symbol: "TSLA", price: 210.2, isPriceUp: true),
        Stock(symbol: "AMZN", price: 123.4, isPriceUp: true)
    ]
    
    private var timer: Timer.TimerPublisher
    private var cancellables = Set<AnyCancellable>()
    private let subject = PassthroughSubject<[Stock], Never>()

    var stockPublisher: AnyPublisher<[Stock], Never> {
        subject.eraseToAnyPublisher()
    }

    init(interval: TimeInterval = 1.5) {
        self.timer = Timer.publish(every: interval, on: .main, in: .common)
        setupTimer()
    }

    private func setupTimer() {
        timer
            .autoconnect()
            .sink { [weak self] _ in
                self?.simulatePriceChange()
            }
            .store(in: &cancellables)
    }

    private func simulatePriceChange() {
        stocks = stocks.map { stock in
            let change = Double.random(in: -2...2)
            let newPrice = max(stock.price + change, 0)
            return Stock(symbol: stock.symbol, price: newPrice, isPriceUp: change >= 0)
        }
        subject.send(stocks)
    }
}
