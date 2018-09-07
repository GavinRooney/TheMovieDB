//
//  JSONHelpers.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

class JSONHelpers {
    
    static func encodeAsDictionary<T: Encodable>(_ data: T) -> [String: Any]? {
        
        guard let dataAsData: Data = try? JSONEncoder().encode(data) else {
            return nil
        }
        
        guard let dataAsJson = try? JSONSerialization.jsonObject(with: dataAsData) else {
            return nil
        }
        
        guard let dataAsDictionary = dataAsJson as? [String: Any] else {
            return nil
        }
        
        return dataAsDictionary
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let err{
            print("Session Error: ",err)
        }
        return nil
    }
}
