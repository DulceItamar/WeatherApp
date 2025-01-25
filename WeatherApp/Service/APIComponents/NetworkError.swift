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
    case badServerResponse
    case badRequest
    case http(httpeResponse: HTTPURLResponse)
    case networkError(String)
    case invalidResponse
    case noData
    case parsingError
    
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
            case .badServerResponse:
                return "Bad request from the Server"
                
            case .http(httpeResponse: let response):
                return "Http Response: \(response)"
            case .badRequest:
                return "Bad request "
            case .invalidResponse:
                return "Invalid Response"
            case .noData:
                return "No data"
                
            case .parsingError:
                return "Error parsing data"
        }
    }
}
