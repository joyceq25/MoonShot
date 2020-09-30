//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Ping Yun on 9/30/20.
//

import Foundation

extension Bundle {
    //generic method to load JSON files into arrays of structs
    //uses <T> as placeholder for certain types, T must conform to Codable
    func decode<T: Codable>(_ file: String) -> T {
        //uses Bundle to find the path to the file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            //app crashes if file can't be found
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        //loads file into an instance of Data
        guard let data = try? Data(contentsOf: url) else {
            //app crashes if file can't be loaded
            fatalError("Failed to load \(file) from bundle.")
        }
        
        //passes it through JSONDecoder
        let decoder = JSONDecoder()
        
        //tells decoder to parse dates in specified format 
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        
        //tries to decode file 
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            //app crashes if file can't be decoded
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
