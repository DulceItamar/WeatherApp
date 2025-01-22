//
//  Weather.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 21/01/25.
//

import Foundation


struct WeatherResponse: Decodable {
    let list: [WeatherData]
    let city: City
}


struct WeatherData: Decodable {
    //dt
    let currentDate: TimeInterval
    
    //main
    let currentTemperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let humidity: Int
    
    //wind
    let windSpeed: Double
    
    //weather
    let weather: Weather
}



extension WeatherData {
    
    enum CodingKeys: String, CodingKey {
        case currentDate = "dt"
        
        case main
        case currentTemperature = "temp"
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
        case humidity
        
        case clouds
        case windSpeed = "speed"
        
        case weather
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.currentDate = try container.decode(TimeInterval.self, forKey: .currentDate)
        
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        self.currentTemperature = try main.decode(Double.self, forKey: .currentTemperature)
        self.maxTemperature = try main.decode(Double.self, forKey: .maxTemperature)
        self.minTemperature = try main.decode(Double.self, forKey: .minTemperature)
        self.humidity = try main.decode(Int.self, forKey: .humidity)
        
        
        let clouds = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .clouds)
        self.windSpeed = try clouds.decode(Double.self, forKey: .windSpeed)
        
        self.weather = try container.decode(Weather.self, forKey: .weather)
    }
}

struct Weather: Decodable {
    let mainLabel: String
    let description: String
    let icon: String
    
    
enum WeatherKeys: String, CodingKey {
    case mainLabel = "main"
    case description
    case icon
}
}

struct City: Decodable {
    var id: String = UUID().uuidString
    let name: String
    let country: String
    let coordinates: Coordinates
    let sunset : TimeInterval
    let sunrise: TimeInterval
    
    enum cityKeys: String, CodingKey {
        case coordinates = "coord"
    }
}


struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
    
    enum CoordinatesKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
}
