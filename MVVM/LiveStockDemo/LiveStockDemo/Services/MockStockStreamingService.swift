//
//  MockStockStreamingService.swift
//  LiveStockDemo
//
//  Created by Sakir Saiyed on 2025-06-29.
//
import Combine
import Foundation

//This protocol defines a single requirement: stockPublisher, which is a Combine publisher that emits an array of Stock objects over time.
protocol StockStreamingService {
    var stockPublisher: AnyPublisher<[Stock], Never> { get }
}

//This class mocks a real-time stock streaming service by simulating stock price updates at regular intervals.
//It conforms to the StockStreamingService protocol.
final class MockStockStreamingService: StockStreamingService {
    private var stocks: [Stock] = [
        Stock(symbol: "AAPL", price: 192.5, isPriceUp: true),
        Stock(symbol: "GOOGL", price: 2789.6, isPriceUp: true),
        Stock(symbol: "TSLA", price: 210.2, isPriceUp: true),
        Stock(symbol: "AMZN", price: 123.4, isPriceUp: true)
    ]
    
    private var timer: Timer.TimerPublisher
    
    //Stores Combine subscriptions to manage memory and cancel publishers when needed.
    private var cancellables = Set<AnyCancellable>()
    
    //A subject that acts as a bridge between internal logic and the public stockPublisher.
    private let subject = PassthroughSubject<[Stock], Never>()

    //Exposes the subject as a read-only AnyPublisher, so consumers can subscribe to stock updates but can't send values
    var stockPublisher: AnyPublisher<[Stock], Never> {
        subject.eraseToAnyPublisher()
    }

    //Initializes the timer to fire every 1.5 seconds (or custom interval).
    init(interval: TimeInterval = 1.5) {
        self.timer = Timer.publish(every: interval, on: .main, in: .common)
        setupTimer()
    }

    //Connects the timer and triggers simulatePriceChange() every time it fires.
    private func setupTimer() {
        timer
            .autoconnect() // starts the timer
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
        subject.send(stocks)//emits the updated stocks array to all subscribers.
    }
}
