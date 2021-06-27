//
//  Activitie.swift
//  HabitTracker
//
//  Created by Johnny Wellington on 12/06/21.
//

import Foundation


struct Activity: Identifiable, Codable, Hashable {
    var id: UUID
    let title: String
    let description: String
}


class TrackedActivities: ObservableObject {
    @Published var activities: [Activity: Int]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let activities = try? decoder.decode([Activity: Int].self, from: data) {
                self.activities = activities
            } else {
                self.activities = [Activity: Int]()
            }
        } else {
            self.activities = [Activity: Int]()
        }
    }
    
    func addActivity(title: String, description: String) {
        let newActivity = Activity(id: UUID(), title: title, description: description)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.activities[newActivity] = 0
        }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.activities) {
            UserDefaults.standard.set(data, forKey: "activities")
        }
    }
    
    func track(count: Int, for activity: Activity) {
        self.activities[activity] = count
        self.save()
    }
    
    private func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.activities) {
            UserDefaults.standard.set(data, forKey: "activities")
        }
    }
}
