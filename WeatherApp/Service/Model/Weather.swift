//
//  Weather.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 21/01/25.
//

import Foundation


struct WeatherResponse: Decodable {
//    let list: [WeatherData]
    let city: City
}


struct WeatherData: Decodable {
    //dt
    let currentDate: Int
    
    //main
    let currentTemperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let humidity: Int
    
    //wind
    let windSpeed: Double
    
    //weather
    let weather: [Weather]
}



extension WeatherData {
    
    enum CodingKeys: String, CodingKey {
        case currentDate = "dt"
        
        case main
        case wind
        case weather
        
    }
    
    
    
    
    enum MainKeys: String, CodingKey {
        case currentTemperature = "temp"
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
        case humidity
        
    }
    
    
    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentDate = try container.decode(Int.self, forKey: .currentDate)
        
        let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        self.currentTemperature = try main.decode(Double.self, forKey: .currentTemperature)
        self.maxTemperature = try main.decode(Double.self, forKey: .maxTemperature)
        self.minTemperature = try main.decode(Double.self, forKey: .minTemperature)
        self.humidity = try main.decode(Int.self, forKey: .humidity)
        
        
        let wind = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        self.windSpeed = try wind.decode(Double.self, forKey: .windSpeed)
        
        
        self.weather = try container.decode([Weather].self, forKey: .weather)
    }
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
    
    

}

struct City: Decodable {
//    var id: String = UUID().uuidString
    let name: String
    let country: String
    let coordinates: Coord
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case coordinates = "coord"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
        self.coordinates = try container.decode(Coord.self, forKey: .coordinates)
    }
}


struct Coord: Decodable {
    let lat: Double
    let lon: Double
}
