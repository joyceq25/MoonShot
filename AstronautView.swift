//
//  AstronautView.swift
//  MoonShot
//
//  Created by Ping Yun on 9/30/20.
//

import SwiftUI

struct AstronautView: View {
    //Astronaut property so AstronautView knows what to show
    let astronaut: Astronaut
    
    var body: some View {
        //lays out astronaut property using similar GeometryReader/ScrollView/VStack combination as MissionView
        GeometryReader{ geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
