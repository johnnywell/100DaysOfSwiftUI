//
//  ContentView.swift
//  Moonshot
//
//  Created by Johnny Wellington on 29/05/21.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var presentDates = true
        
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if presentDates {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text("\(getCrewNames(mission))")
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("\(presentDates ? "Crew": "Launch")", action: { self.presentDates.toggle() }))
        }
    }
    
    func getCrewNames(_ mission: Mission) -> String {
        if presentDates {
            return mission.formattedLaunchDate
        }
        return self.astronauts.filter { astronaut in
            mission.crew.contains { member in
                member.name == astronaut.id
            }
        }
        .map({ $0.name }).joined(separator: ", ")
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
