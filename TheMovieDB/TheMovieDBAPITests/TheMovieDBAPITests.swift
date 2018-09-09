//
//  TheMovieDBAPITests.swift
//  TheMovieDBAPITests
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import XCTest

// The following tests are to check the api responses and make sure they are always what we expect. we can quickly see if any server side changes breaks the api / client contract
// While testing for this is often done on server side, I like to also have tests for each api response and models used. This helps to keep everyone honest

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
        
        let moviesWorker = GetMoviesWorker()
        let promise = expectation(description: "Status code: 200")
        
        moviesWorker.request(query: "batman", page: 1, completion: { response in
            
            guard response.page != nil else {
                return
            }
            
            guard response.totalPages != nil else {
                return
            }
            
            guard response.totalResults != nil else {
                return
            }
            
            if let results = response.results {
                if let movie = results.first {
                    
                    guard movie.voteCount != nil else {
                        return
                    }
                    guard movie.voteAverage != nil else {
                        return
                    }
                    guard movie.posterPath != nil else {
                        return
                    }
                    guard movie.originalLanguage != nil else {
                        return
                    }
                    guard movie.originalTitle != nil else {
                        return
                    }
                    guard movie.backdropPath != nil else {
                        return
                    }
                    guard movie.overview != nil else {
                        return
                    }
                    guard movie.releaseDate != nil else {
                        return
                    }
                    guard movie.genreIds != nil else {
                        return
                    }
                    guard movie.popularity != nil else {
                        return
                    }
                    guard movie.adult != nil else {
                        return
                    }
                    guard movie.title != nil else {
                        return
                    }
                    guard movie.id != nil else {
                        return
                    }
                    guard movie.video != nil else {
                        return
                    }
                }
            }
            
            promise.fulfill()
            
        }) { error in
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetGenresAPIResponse() {
        
        let genreWorker = GetGenresWorker()
        let promise = expectation(description: "Status code: 200")
        
        genreWorker.request(completion: { response in
            
            guard response.genres != nil else {
                return
            }
            

            if let genres = response.genres {
                if let genre = genres.first {
                    
                    guard genre.id != nil else {
                        return
                    }
                    guard genre.name != nil else {
                        return
                    }
                }
            }
            
            promise.fulfill()
            
        }) { error in
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetConfigAPIResponse() {
        
        let worker = GetMovieDBConfigWorker()
        let promise = expectation(description: "Status code: 200")
        
        worker.request(completion: { response in
            
            guard response.images != nil else {
                return
            }
            
            
            if let imagesConfig = response.images {
                guard imagesConfig.secureBaseUrl != nil else {
                    return
                }
                guard imagesConfig.baseUrl != nil else {
                    return
                }
                guard imagesConfig.posterSizes != nil else {
                    return
                }
                
            }
            
            promise.fulfill()
            
        }) { error in
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


    
}
