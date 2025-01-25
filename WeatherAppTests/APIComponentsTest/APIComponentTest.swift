//
//  RouterAPIComponentTest.swift
//  WeatherAppTests
//
//  Created by Dulce Itamar Vigueras Ballesteros on 23/01/25.
//

import XCTest
@testable import WeatherApp

final class APIComponentTest: XCTestCase {
    

    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testRouterOfAPIComponentsGetWeatherURLIsRight() throws {
        let router = Router(appEnviroment: .baseURL)
     
        let coordinates = Coord(lat: 44.34, lon: 10.99)
        let endpoint = Endpoint(coordinates: coordinates, method: .GET)
       
       
        let api: String =  try Configuration.value(for: "API_KEY")
        
        let expectedURL =  try router.getWeatherURL(endpoint: endpoint)
        
        if let expectedURL = expectedURL {
            XCTAssertEqual(String(describing: expectedURL), "https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=\(api)")
        }
    }
    
    
    func testRequesterOfAPIComponentsGetWeatherURLIsRight() throws {
        let requester = Requester()
        let router = Router(appEnviroment: .baseURL)
     
        let coordinates = Coord(lat: 44.34, lon: 10.99)
        let endpoint = Endpoint(coordinates: coordinates, method: .GET)
       
        
        let expectedURL =  try router.getWeatherURL(endpoint: endpoint)
        
        let expectation = expectation(description: "Requester completes network call and parses data")
        
        
        requester.execute(url: expectedURL!, endpoint: endpoint) { result in
            switch result {
                case .success(let data):
                   
                    print("Data received: \(data)")
                    XCTAssertNotNil(data)
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                    print("Error occurred: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testParserOfAPIComponentsGetWeatherURLIsRight() throws {
        let requester = Requester()
        let router = Router(appEnviroment: .baseURL)
        let parser = Parser()
     
        let coordinates = Coord(lat: 44.34, lon: 10.99)
        let endpoint = Endpoint(coordinates: coordinates, method: .GET)
       
        
        let expectedURL =  try router.getWeatherURL(endpoint: endpoint)
        
        // Crear una expectativa para manejar la asincronía
           let expectation = expectation(description: "Requester completes network call and parses data")
        
        requester.execute(url: expectedURL!, endpoint: endpoint) { result in
            
            
            switch result {
                case .success(let data):
                   let weatherResponse = parser.parse(data: data, type: WeatherResponse.self)
                    print("Received data: \(data)")
                    print("Data received: \(String(describing: weatherResponse?.city.name))")
                    
                    XCTAssertNotNil(weatherResponse)
                case .failure(let error ):
                    XCTFail("Request failed with error: \(error)")
                    print("Error occurred: \(error)")
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
