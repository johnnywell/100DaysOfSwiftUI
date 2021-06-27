//
//  ContentView.swift
//  Bookworm
//
//  Created by Johnny Wellington on 23/06/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddSrceen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deletBooks)
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action : {
                self.showingAddSrceen.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddSrceen) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deletBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            self.moc.delete(book)
        }
        
        // save the context
        try? self.moc.save()
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
