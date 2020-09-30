//
//  Astronaut.swift
//  MoonShot
//
//  Created by Ping Yun on 9/30/20.
//

import Foundation

//struct that holds data about astronaut 
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
