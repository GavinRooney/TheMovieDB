//
//  GenreManager.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

let kLastSavedTimeStampKey = "moviedbLastSavedGenreList"

class GenreManager {
    
    static let shared = GenreManager()
    var fileManager = FileManager()
    var genres : [Genre]?
    
    let fileName = "genres"
    let fileExtention = "json"
    
    init() {
        
        // Check for local written file
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            
            
            do {
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let genresResponse = JSONHelpers.decode(MovieGenresResponse.self, from: data)
                self.genres = genresResponse?.genres
            } catch {
                // if no file has been written to docs then use the bundled file
                self.genres = self.readLocalBundledGenres()
            }
            
        } catch {
            print(error)
        }
        
    }
    
    // stubbed setup
    func setup() {
        
    }
    
    public func checkForUpdates () {
        let defaults = UserDefaults.standard

        let lastSaved = defaults.double(forKey: kLastSavedTimeStampKey)
        if lastSaved > 0 {
            let updateList = isUpdateNeeded(timeStamp: lastSaved)
            if updateList {
                self.updateGenres()
            }
        } else {
            self.updateGenres()
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
    
    private func updateGenres () {
        GetGenresWorker().request(completion: { response in
            
            if let genres = response.genres, genres.count > 0 {
                self.genres = genres
                guard let dataAsData: Data = try? JSONEncoder().encode(genres) else {
                    print("Cannot encode data: \(String(describing: genres))")
                    return
                }
                self.saveData(dataAsData)
                let defaults = UserDefaults.standard
                defaults.set(Date.timeIntervalSinceReferenceDate, forKey: kLastSavedTimeStampKey)
            }
        }, failure: { error in
            
        })
    }
    
    private func isUpdateNeeded (timeStamp: Double) -> Bool {
        
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSinceReferenceDate: timeStamp)
        
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        // if day is in the past and the absolute value of it is > = 5 then we should call api to update the list
        // I have give arbitrary time of 5 days between updates to highlight a possible use case
        if day < 1 && abs(day) >= 5 {
            return true
        }
        
        return false
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
    
    private func saveData(_ data: Data) {
        
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
            let fileURL = documentDirectory.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            
            do {
                // Write contents to file
                try data.write(to:fileURL)
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
        } catch {
            print(error)
        }
        
    }
    
}
