//
//  MovieDBConfigManager.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

let kLastSavedTimeStampConfigKey = "moviedbLastSavedConfig"

class MovieDBConfigManager: RemoteUpdater {
    
    static let shared = MovieDBConfigManager()
    var movieDBConfig : MovieDBConfigResponse?
    
    override init() {
        
        super.init()
        
        self.fileName = "moviedbconfig"
        self.fileExtention = "json"
        
        // Check for local written file
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName ?? "").appendingPathExtension(fileExtention ?? "")
            
            
            do {
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let config = JSONHelpers.decode(MovieDBConfigResponse.self, from: data)
                self.movieDBConfig = config
            } catch {
                // if no file has been written to docs then use the bundled file
                self.movieDBConfig = self.readLocalBundledConfig()
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    override func update () {
        GetMovieDBConfigWorker().request(completion: { response in
            
            
            self.movieDBConfig = response
            guard let dataAsData: Data = try? JSONEncoder().encode(response) else {
                print("Cannot encode data: \(String(describing: response))")
                return
            }
            self.saveData(dataAsData)
            let defaults = UserDefaults.standard
            defaults.set(Date.timeIntervalSinceReferenceDate, forKey: kLastSavedTimeStampConfigKey)
            
        }, failure: { error in
            
        })
    }
    
    private func readLocalBundledConfig () -> MovieDBConfigResponse? {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtention) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        
        // always move the data to docs directory for future reference
        saveData(data)
        
        guard let configResponse = JSONHelpers.decode(MovieDBConfigResponse.self, from: data) else {
            return nil
        }
        
        return configResponse
        
    }
    
    
}

extension MovieDBConfigManager {
    
    func downloadThumbnailImageUrl(fileName : String?) -> URL? {
        // confirm that we have everything we need to make a valid url
        // I will always use smallest poster size in this case
        if let fileName = fileName, let config = self.movieDBConfig, let imageConfig = config.images, let baseUrl = imageConfig.secureBaseUrl, let posterSize = imageConfig.posterSizes?.first {
            let fullPath = baseUrl + posterSize + fileName
            return URL(string: fullPath)
        }
        return nil
        
    }
    
    
    
}
