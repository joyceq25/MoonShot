//
//  MissionView.swift
//  MoonShot
//
//  Created by Ping Yun on 9/30/20.
//

import SwiftUI

struct MissionView: View {
    //nested struct with crew member data
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    //stores array of CrewMember objects
    let astronauts: [CrewMember]
    
    //mission property to show mission badge and description
    let mission: Mission
    
    var body: some View {
        GeometryReader { geometry in
            //scrolling VStack
            ScrollView(.vertical) {
                VStack {
                    //resizable image for mission badge
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        //uses GeometryReader to set max width of mission image
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    //text view that shows mission description
                    Text(self.mission.description)
                        .padding()
                    
                    //shows astronaut data
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                //pushes views to left
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        //asks SwiftUI to render contents of NavigationLink as plain button, no coloring to image or text
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    //spacer so everything gets pushed to top of screen with min height of 25 points
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    //custom initializer that accepts mission it represents and all the astronauts, stores mission away and figures out array of resolved astronauts
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .previewDevice("iPhone 11")
    }
}
