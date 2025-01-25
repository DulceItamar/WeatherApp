//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 22/01/25.
//

import Foundation
protocol EndPointProtocol {

    var method: HTTPMethod { get }
}

/*
 https://api.openweathermap.org/data/2.5/forecast?lat= {lat}&lon={lon}&appid={API key}
 */

struct Endpoint: EndPointProtocol {
    var coordinates: Coord
    var method: HTTPMethod

}


enum HTTPMethod: String {
    case GET
}



