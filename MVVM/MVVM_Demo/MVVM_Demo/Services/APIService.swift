//
//  APIService.swift
//  MVVM_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//

import Foundation
import Combine 

class APIService: APIServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

