//
//  ContentView.swift
//  MoonShot
//
//  Created by Ping Yun on 9/29/20.
//

import SwiftUI

struct ContentView: View {
    //loads astronaut JSON into content view
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    //loads mission JSON into content view
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            //list with missions array as input
            List(missions) { mission in
                //each row of list has NavigationLink containing the image, name, and launch date of mission, pushes to MissionView
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        //image occupies 44x44 space while maintaining original aspect ratio
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        //shows formatted launch date in text view
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
