//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case httpError(Int)
    case decodingError(String)
    
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL."
            case .httpError(let statusCode):
                return "HTTP Error: Received status code \(statusCode)"
            case .decodingError(let message):
                return "Decoding error: \(message)"
            case .networkError(let message):
                return "NetworkError: \(message) "
        }
    }
}
