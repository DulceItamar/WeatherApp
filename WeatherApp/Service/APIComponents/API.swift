//
//  API.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation

protocol APIWeatherProtocol {
    func fetchWeatherData(coordinates: Coord,  completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
}

class APIWeather: APIWeatherProtocol {
 
    
    private let router = Router(appEnviroment: .baseURL)
    
    private let requester = Requester()
    private let parser = Parser()
    
    
    func fetchWeatherData(coordinates: Coord, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        let endpoint = Endpoint(coordinates: coordinates, method: .GET)
        
        guard let url = try? self.router.getWeatherURL(endpoint: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
      
        
        requester.execute(
            url: url,
            endpoint: endpoint) { result in
                switch result {
                    case .success(let data):
                        if let weatherResponse = self.parser.parse(data: data, type: WeatherResponse.self) {
                                      completion(.success(weatherResponse))
                                  } else {
                                      completion(.failure(.parsingError))
                                  }
                    case .failure(let error):
                        print("Error occurred: \(error)")
                }
            }
    }
}
