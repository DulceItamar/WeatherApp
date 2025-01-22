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
    var method: HTTPMethod
    
    
}


enum HTTPMethod: String {
    case GET
}
