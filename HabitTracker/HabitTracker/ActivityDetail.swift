//
//  ActivityDetail.swift
//  HabitTracker
//
//  Created by Johnny Wellington on 12/06/21.
//

import SwiftUI

struct ActivityDetail: View {
    var activity: Activity
    @ObservedObject var tracker: TrackedActivities
    
    private var counter: Binding<Int> { Binding(
        get: {
            self.tracker.activities[activity] ?? 0
        },
        set: {
            self.tracker.track(count: $0, for: activity)
        }
    )}
    
    var body: some View {
        VStack {
            Text(self.activity.description)
                .padding()
            
            Text("\(self.counter.wrappedValue)")
                .font(.largeTitle)
            
            Button("Register activity") {
                self.counter.wrappedValue += 1
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .navigationTitle(self.activity.title)
        
    }
    
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: Activity(id: UUID(), title: "Placeholder", description: "Placeholder is nice!"), tracker: TrackedActivities())
    }
}
