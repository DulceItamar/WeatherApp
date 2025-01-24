//
//  Requester.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation
protocol RequesterProtocol {
    func execute(url: URL, endpoint: Endpoint, complentionBlock: @escaping (Result<Data, NetworkError>)  -> () )
}
//
//
class Requester: RequesterProtocol {
    func execute(url: URL, endpoint: Endpoint, complentionBlock: @escaping (Result<Data,NetworkError>)  -> ()) {
        
        
        let urlRequest = buildRequest(url: url, endpoint: endpoint)
    
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            //Handle errors
            if let error = error {
                complentionBlock(.failure(.networkError(error.localizedDescription)))
                return
            }
            //Verify the HTTP status code
            guard let httpResponse = response as? HTTPURLResponse else {
                complentionBlock(.failure(.invalidResponse))
                return
            }
        
            
            guard (200...299).contains(httpResponse.statusCode) else {
                complentionBlock(.failure(.http(httpeResponse: httpResponse)))
                return
            }
   
            guard let data = data else {
                complentionBlock(.failure(.noData))
                return
            }
            
            
            complentionBlock(.success(data))
            return
         
        }
    }
    
    
    private func buildRequest(url: URL, endpoint: Endpoint) -> URLRequest {
        //Build URL Request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        return request
    }




    
}
