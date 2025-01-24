//
//  AppEnvironment.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 24/01/25.
//

import Foundation


enum AppEnvironment {
    case baseURL
    
    var base: String {
        switch self {
            case .baseURL:
                return "https://api.openweathermap.org/data/2.5/forecast"
        }
    }
}
