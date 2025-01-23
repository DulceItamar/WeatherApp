//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 22/01/25.
//

import Foundation
protocol EndPoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: AnyObject]? { get }
}

/*
 https://api.openweathermap.org/data/2.5/forecast?lat= {lat}&lon={lon}&appid={API key}
 */

struct APIEndpoint {
    var coordinates: Coordinates
    var apiKey: String
    var method: HTTPMethod
    var queries: [URLQueryItem]
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
 
    
    
    func getEndpoint() -> URL {
        
        let latitude = String(describing: coordinates.latitude)
        let longitude = String(describing: coordinates.longitude)
//        let apiKey: String = try Configuration.value(for: "API_KEY")
        
        var lastEndpoint : URL {
            let endpoint = URL(string: APIEndpoint.baseURL)!
                .appending(queryItems: [
                    URLQueryItem(name: "lat", value: latitude),
                    URLQueryItem(name: "long", value: longitude),
                    URLQueryItem(name: "appid", value: apiKey),
            ])
            
            print(endpoint)
            return endpoint
        }
        
        return lastEndpoint
    }
    
}


enum HTTPMethod: String {
    case GET
}
