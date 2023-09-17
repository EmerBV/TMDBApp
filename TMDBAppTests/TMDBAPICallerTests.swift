//
//  TMDBAPICallerTests.swift
//  TMDBAppTests
//
//  Created by Emerson Balahan Varona on 17/9/23.
//

import XCTest
@testable import TMDBApp

final class TMDBAPICallerTests: XCTestCase {
    
    let apiCaller = TMDBAPICaller.shared
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetTrendingMovies() {
        let expectation = XCTestExpectation(description: "Espera la respuesta de getTrendingMovies")
        
        apiCaller.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                XCTAssertFalse(titles.isEmpty)
            case .failure(let error):
                XCTFail("Error al obtener las películas: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetTrendingTvs() {
        let expectation = XCTestExpectation(description: "Espera la respuesta de getTrendingTvs")
        
        apiCaller.getTrendingTvs { result in
            switch result {
            case .success(let titles):
                XCTAssertFalse(titles.isEmpty)
            case .failure(let error):
                XCTFail("Error al obtener las películas: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
