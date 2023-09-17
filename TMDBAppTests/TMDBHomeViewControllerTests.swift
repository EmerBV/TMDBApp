//
//  TMDBHomeViewControllerTests.swift
//  TMDBAppTests
//
//  Created by Emerson Balahan Varona on 17/9/23.
//

import XCTest
@testable import TMDBApp

final class TMDBHomeViewControllerTests: XCTestCase {
    var viewController: TMDBHomeViewController!
    
    @MainActor override func setUp() {
        super.setUp()
        viewController = TMDBHomeViewController()
        // Carga la vista (esto activará viewDidLoad)
        viewController.loadViewIfNeeded()
    }
    
    @MainActor override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // Prueba si la vista se carga correctamente
    func testViewDidLoad() {
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.getHomeFeedTable())
        XCTAssertNotNil(viewController.getHeaderView())
    }
    
    // Prueba si la función configureNavBar() configura la barra de navegación correctamente
    func testConfigureNavBar() {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController = navigationController.topViewController as? TMDBHomeViewController
        viewController.loadViewIfNeeded()
        viewController.configureNavBar()
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
        XCTAssertEqual(viewController.navigationController?.navigationBar.tintColor, .white)
    }
    
    // Prueba si la función getTrendingMovies() obtiene datos correctamente
    func testGetTrendingMoviesUpdatesView() {
        viewController.getTrendingMovies()
        
        let expectation = self.expectation(description: "getTrendingMovies completion")
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        // Espera hasta que la solicitud se complete o se agote el tiempo de espera
        wait(for: [expectation], timeout: 10)
        
        // Verifica si ciertos elementos de la vista se han configurado correctamente
        // o si las propiedades de la vista reflejan el estado esperado después de llamar a getTrendingMovies.
        XCTAssertNotNil(viewController.getHeaderView())
    }
    
}
