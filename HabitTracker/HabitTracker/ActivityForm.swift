//
//  ActivityForm.swift
//  HabitTracker
//
//  Created by Johnny Wellington on 12/06/21.
//

import SwiftUI

struct ActivityForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State var titleInput = ""
    @State var descriptionInput = ""
    @ObservedObject var trackedActivities: TrackedActivities
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $titleInput)
                TextField("Description", text: $descriptionInput)
            }
            .navigationTitle("Activity")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(leading: Button("Cancel", action: self.cancel ), trailing: Button("Add", action: self.addActivity))
        }
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func addActivity() {
        self.trackedActivities.addActivity(title: self.titleInput, description: self.descriptionInput)
        self.titleInput = ""
        self.descriptionInput = ""
        presentationMode.wrappedValue.dismiss()
    }
}

struct ActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        ActivityForm(trackedActivities: TrackedActivities())
    }
}
