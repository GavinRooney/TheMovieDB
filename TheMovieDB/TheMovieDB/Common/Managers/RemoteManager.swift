//
//  RemoteManager.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation


class RemoteManager {

    var fileManager = FileManager()
    var fileName:String?
    var fileExtention:String?
    
    init() {
        
    }
    
    // stubbed setup
    func setup() {
        
    }
    
    public func checkForUpdates (key : String) {
        let defaults = UserDefaults.standard
        
        let lastSaved = defaults.double(forKey: key)
        if lastSaved > 0 {
            let updateList = isUpdateNeeded(timeStamp: lastSaved)
            if updateList {
                self.update()
            }
        } else {
            self.update()
        }
    }
    
    
    func update () {
        
    }
    
    private func isUpdateNeeded (timeStamp: Double) -> Bool {
        
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSinceReferenceDate: timeStamp)
        
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        // if day is in the past and the absolute value of it is > = 5 then we should call api to update the list
        // I have give arbitrary time of 5 days between updates as recommended by movie db doc
        if day < 1 && abs(day) >= 5 {
            return true
        }
        
        return false
    }
    
    
    func saveData(_ data: Data) {
        
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
            let fileURL = documentDirectory.appendingPathComponent(fileName ?? "").appendingPathExtension(fileExtention ?? "")
            
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
