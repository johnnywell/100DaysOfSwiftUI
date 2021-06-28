//
//  AddBookView.swift
//  Bookworm
//
//  Created by Johnny Wellington on 25/06/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date()
    
    @State private var genreValidationMessage = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Sci-Fi"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text(genreValidationMessage).foregroundColor(.red)) {
                    TextField("Name of book", text: $title)
                    TextField("AUthor's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    DatePicker("Read on", selection: $date, in: ...date, displayedComponents: [.date])
                }
                
                Section {
                    Button("Save") {
                        if self.genre == "" {
                            self.genreValidationMessage = "You didn't select a genre"
                        } else {
                            let newBook = Book(context: self.moc)
                            newBook.title = self.title
                            newBook.author = self.author
                            newBook.date = self.date
                            newBook.rating = Int16(self.rating)
                            newBook.genre = self.genre
                            newBook.review = self.review
                            
                            try? self.moc.save()
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
