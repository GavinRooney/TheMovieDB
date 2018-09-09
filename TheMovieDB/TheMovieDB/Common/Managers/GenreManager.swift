//
//  GenreManager.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

let kLastSavedTimeStampGenreKey = "moviedbLastSavedGenreList"

class GenreManager: RemoteUpdater {
    
    static let shared = GenreManager()
    var genres : [Genre]?
    
    override init() {
        
        super.init()
        
        self.fileName = "genres"
        self.fileExtention = "json"
        
        // Check for local written file
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName ?? "").appendingPathExtension(fileExtention ?? "")
            
            
            do {
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let genres = JSONHelpers.decode([Genre].self, from: data)
                self.genres = genres
            } catch {
                // if no file has been written to docs then use the bundled file
                self.genres = self.readLocalBundledGenres()
            }
            
        } catch {
            print(error)
        }
        
    }
    

    public func getGenre(withID genreID: Int) -> Genre? {
        if let genres = self.genres {
            for genre in genres {
                if genre.id == genreID {
                    return genre
                }
            }
        }
        return nil
    }
    
    public func constructGenreSentence(genreIDs: [Int]?) -> String {
        if let genres = genreIDs {
            var genreText = ""
            for genreID in genres {
                let genre = GenreManager.shared.getGenre(withID: genreID)
                if genreText.count > 0 {
                    genreText += ", " + (genre?.name ?? "")
                } else {
                    genreText = genre?.name ?? ""
                }
                
            }
            return genreText
            
        }
        return ""
    }
    
    override func update () {
        GetGenresWorker().request(completion: { response in
            
            if let genres = response.genres, genres.count > 0 {
                self.genres = genres
                guard let dataAsData: Data = try? JSONEncoder().encode(genres) else {
                    print("Cannot encode data: \(String(describing: genres))")
                    return
                }
                self.saveData(dataAsData)
                let defaults = UserDefaults.standard
                defaults.set(Date.timeIntervalSinceReferenceDate, forKey: kLastSavedTimeStampGenreKey)
            }
        }, failure: { error in
            
        })
    }
    
    private func readLocalBundledGenres () -> [Genre]? {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtention) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        
        // always move the data to docs directory for future reference
        saveData(data)
        
        guard let genresResponse = JSONHelpers.decode(MovieGenresResponse.self, from: data) else {
            return nil
        }
        
        return genresResponse.genres
        
    }
    
    
}
