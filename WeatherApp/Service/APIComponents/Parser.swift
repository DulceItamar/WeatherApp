//
//  Parser.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import Foundation

protocol ParserProtocol {
    func parse<T: Decodable>(data: Data, type: T.Type) -> T?
}


final class Parser: ParserProtocol {
    
    
    func parse<T>(data: Data, type: T.Type) -> T? where T : Decodable {
        do {
            let jsonDecoder = JSONDecoder()
            
            let decodableData = try jsonDecoder.decode(T.self, from: data)
            return decodableData
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
}
