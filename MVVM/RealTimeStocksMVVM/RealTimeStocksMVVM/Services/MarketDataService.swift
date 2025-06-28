//
//  MarketDataService.swift
//  RealTimeStocksMVVM
//
//  Created by Sakir Saiyed on 2025-06-26.
//

import SwiftUI
import Combine
// MARK: - Data Layer (Mock WebSocket)

protocol MarketDataProviding {
    var tickerStream: AnyPublisher<[Stock], Never> { get }
    func connect()
    func disconnect()
}

class MarketDataService: MarketDataProviding {
        
    private let subject = PassthroughSubject<[Stock], Never>()
    private var timer: AnyCancellable?
    
    private var stocks: [Stock] = [
        Stock(symbol: "AAPL", price: 180, isPriceUp: true),
        Stock(symbol: "GOOG", price: 2700, isPriceUp: false),
        Stock(symbol: "AMZN", price: 3300, isPriceUp: true),
        Stock(symbol: "TSLA", price: 700, isPriceUp: true),
        Stock(symbol: "MSFT", price: 280, isPriceUp: false),
        Stock(symbol: "NVDA", price: 1000, isPriceUp: true),
        Stock(symbol: "JPM", price: 120, isPriceUp: false),
        Stock(symbol: "NFLX", price: 200, isPriceUp: true),
        Stock(symbol: "META", price: 220, isPriceUp: false),
        Stock(symbol: "AMD", price: 140, isPriceUp: true)
    ]
    
    var tickerStream: AnyPublisher<[Stock], Never> {
        subject.eraseToAnyPublisher()
    }
    
    func connect() {
        timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.sendUpdates() }
    }
    
    func disconnect() {
        timer?.cancel()
        timer = nil
    }
    
    private func sendUpdates() {
        stocks = stocks.map { stock in
            let change = Double.random(in: -2...2)
            let newPrice = max(stock.price + change, 0)
            return Stock(symbol: stock.symbol, price: newPrice, isPriceUp: change >= 0)
        }
        subject.send(stocks)
    }
    
}
