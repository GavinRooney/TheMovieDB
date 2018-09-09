//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Gavin on 05/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import XCTest
@testable import TheMovieDB


class TheMovieDBTests: XCTestCase {
    
    var fileManager = FileManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}

// Mark: - Extension Tests
extension TheMovieDBTests {
    
    func test_localized() {
        // just testing if .localized works
        XCTAssertEqual("MOVIES".localized, "Movies")
    }
    
    func test_removingWhitespaces() {
        XCTAssertEqual("  qwerty ".removingWhitespaces(), "qwerty")
    }
    
    func test_getYearFromDateString() {
        
        let year = Date.getYear(dateText: "1981-01-02")
        XCTAssertEqual(year, "1981")
        
        let nilYear = Date.getYear(dateText: nil)
        XCTAssertEqual(nilYear, nil)
        
        let notValidDateYear = Date.getYear(dateText: "not valid date string")
        XCTAssertEqual(notValidDateYear, nil)
        
        let notExpectedDateFormatYear = Date.getYear(dateText: "01-01-1981")
        XCTAssertEqual(notExpectedDateFormatYear, nil)
    }
}

// Mark: - Business logic Tests
extension TheMovieDBTests {
    
    func test_creatingMovieFromLocalTestData() {
        let movie1 = createMovie(fileName: "movie1")
        
        XCTAssertNotNil(movie1)
    }
    
    func test_popularitySortingHighestFirst() {
        // correct order of popularity is Movie 3,2,1,4
        let movie1 = createMovie(fileName: "movie1")!
        let movie2 = createMovie(fileName: "movie2")!
        let movie3 = createMovie(fileName: "movie3")!
        let movie4 = createMovie(fileName: "movie4")!
        
        
        let unorderedList = [movie1, movie2, movie3, movie4]
        let interactor = MovieListInteractor()
        let orderedList = interactor.sortByPopularity(results: unorderedList)
        
        XCTAssertEqual(movie3.id, orderedList[0].id)
        XCTAssertEqual(movie2.id, orderedList[1].id)
        XCTAssertEqual(movie1.id, orderedList[2].id)
        XCTAssertEqual(movie4.id, orderedList[3].id)
        
    }
    
}

// Mark: Helpers
extension TheMovieDBTests {

    func createMovie(fileName :String) -> Movie? {

        let testBundle = Bundle(for: type(of: self))
        guard let ressourceURL = testBundle.url(forResource: fileName, withExtension: "json") else {
            // file does not exist
            return nil
        }
        do {
            let ressourceData = try Data(contentsOf: ressourceURL)
            let movie = JSONHelpers.decode(Movie.self, from: ressourceData)
            return movie
        } catch _ {
            return nil
        }
    }
}
