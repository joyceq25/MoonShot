//
//  Mission.swift
//  MoonShot
//
//  Created by Ping Yun on 9/30/20.
//

import Foundation

//nested struct that stores ID integer, optional launch date, array of crew roles, description String
struct Mission: Codable, Identifiable {
    //stores name and string of crew roles
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    //computed property to send display name back
    var displayName: String {
        "Apollo \(id)"
    }
    
    //computed property, asks mission to convert optional launch date to formatted string or sends back "N/A" for missing dates 
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    //computed property to send image back 
    var image: String {
        "apollo\(id)"
    }
}
