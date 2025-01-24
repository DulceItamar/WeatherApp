//
//  Router.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation


protocol RouterProtocol{
    func getWeatherURL(endpoint: Endpoint) throws -> URL?
}



class Router: RouterProtocol {
    
    let appEnviroment: AppEnvironment
    
    init(appEnviroment: AppEnvironment) {
        self.appEnviroment = appEnviroment
    }
    
    func getWeatherURL(endpoint: Endpoint) throws -> URL? {
        let url = URL(string: appEnviroment.base)
        
        guard let url = url else { throw NetworkError.invalidURL }
        
        let latiude = String(describing: endpoint.coordinates.latitude)
        let longitude = String(describing: endpoint.coordinates.longitude)
        let apiKey: String  = try Configuration.value(for: "API_KEY")
        
        
        
        let lastURL = url.appending(queryItems: [
            URLQueryItem(name: "lat", value: latiude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: apiKey),
            
        ])

        return lastURL
    }
}
