//
//  TheMovieDBAPITests.swift
//  TheMovieDBAPITests
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import XCTest

// The following tests are to check the api responses and make sure they are always what we expect. we can quickly see if any server side changes breaks the api / client contract
// While testing for this is often done on server side I like to also have tests for each api response and models used to keep everyone honest

class TheMovieDBAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetMoviesAPIResponse() {
        // given
        
        let moviesWorker = GetMoviesWorker()
        let promise = expectation(description: "Status code: 200")
        
        moviesWorker.request(query: "batman", page: 1, completion: { response in
            
            promise.fulfill()
            
        }) { error in
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
