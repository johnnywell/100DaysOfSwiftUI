//
//  AstronautView.swift
//  Moonshot
//
//  Created by Johnny Wellington on 31/05/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                
                Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                
                Text("Missions")
                    .font(.title)
                    .padding(.horizontal)
                    .frame(maxWidth: geometry.size.width, alignment: .leading)
                
                ForEach(self.missions) { mission in
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)

                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        self.missions = missions.filter { mission in
            mission.crew.contains { member in
                member.name == astronaut.id
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
