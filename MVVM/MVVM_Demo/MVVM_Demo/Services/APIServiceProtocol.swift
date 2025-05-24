//
//  APIServiceProtocol.swift
//  MVVM_SwiftUI_Combine_Demo
//
//  Created by Sakir Saiyed on 23/05/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: String) -> AnyPublisher<T, Error>
}
