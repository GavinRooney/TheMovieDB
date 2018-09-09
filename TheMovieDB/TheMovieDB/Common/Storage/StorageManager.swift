//
//  StorageManager.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation
import RealmSwift

let kLastSavedMovieQuery = "moviedbLastSavedMovieQuery"

class MovieDataStore : Object {
    
    @objc private dynamic var structData:Data? = nil
    
    var movieData : Movie? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(Movie.self, from: data)
            }
            return nil
        }
        set {
            structData = try? JSONEncoder().encode(newValue)
        }
    }
    
    @objc dynamic var id: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class StorageManager {
    
    static func storeMovieQuery(_ query: String) {
        UserDefaults.standard.set(query, forKey: kLastSavedMovieQuery)
        UserDefaults.standard.synchronize()
    }
    
    static func getLastMovieQuery() -> String? {
        return UserDefaults.standard.string(forKey: kLastSavedMovieQuery)
    }
    
    static func storeMovieList(movieList :[Movie], complete: (() -> Void)? = nil) {
        
        
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                for movie in movieList {
                    let movieDataStore = MovieDataStore()
                    movieDataStore.movieData = movie
                    movieDataStore.id = String(movie.id ?? 0) 
                    
                    try! realm.write {
                        realm.add(movieDataStore, update: true)
                    }
                }
                if let complete = complete {
                    complete()
                }
            }
        }
    }
    
    
    static func getStoredMovieList (complete: @escaping([Movie]) -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let storedMovies = realm.objects(MovieDataStore.self)
                
                var movieList = [Movie]()
                
                for movie in storedMovies {
                    if let data = movie.movieData {
                        movieList.append(data)
                    }
                }
                
                complete(movieList)
            }
        }
        
    }
    
    static func clearAll () {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
            }
        }
    }
    
}



