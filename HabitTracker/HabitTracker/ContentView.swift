//
//  ContentView.swift
//  HabitTracker
//
//  Created by Johnny Wellington on 12/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var trackedActivities = TrackedActivities()
    @State var isShowingAddActivitySheet = false

    
    var body: some View {
        NavigationView {
            List{
                ForEach(self.trackedActivities.activities.keys.sorted(by: { $0.title < $1.title })) { activity in
                    NavigationLink(destination: ActivityDetail(activity: activity, tracker: trackedActivities)) {
                        Text(activity.title)
                    }
                }
            }
            .navigationBarItems(trailing:
                Button(action: {self.isShowingAddActivitySheet.toggle()}) {
                    Image(systemName: "plus.circle.fill")
            })
            .navigationTitle("Habit Tracker")
            .sheet(isPresented: $isShowingAddActivitySheet) {
                ActivityForm(trackedActivities: self.trackedActivities)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
