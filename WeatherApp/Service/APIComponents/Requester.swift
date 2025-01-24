//
//  Requester.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation
protocol RequesterProtocol {
    func execute(endpoint: APIEndpoint, complentionBlock: @escaping (Result<Data, Error>) -> () )
}


class Requester: RequesterProtocol {
    func execute(endpoint: APIEndpoint, complentionBlock: @escaping (Result<Data, any Error>) -> ()) {
        
    }
    
    //Build URL Request
    func buildURLRequest(endpoint: APIEndpoint) throws -> URLRequest? {
        var urlRequest = try URLRequest(url: endpoint.getEndpoint())
    }

    
}
