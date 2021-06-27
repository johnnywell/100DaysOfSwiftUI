//
//  ContentView.swift
//  iExpense
//
//  Created by Johnny Wellington on 25/05/21.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let type: String
    let amount: Int
    let date: Date
    
    init(id: UUID = UUID(), name: String, type: String, amount: Int, date: Date) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
    }
}


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}


struct ExpenseType: View {
    let type: String
    
    var body: some View {
        if type == "Business" {
            Text(type)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.primary)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
        }
        if type == "Personal" {
            Text(type)
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
        }
        
    }
}


struct ContentView: View {
    @State private var showingAddExpenses = false
    @ObservedObject var expenses = Expenses()
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            ExpenseType(type: item.type)
                        }
                        Text("\(item.date)")
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(expenseColor(item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                trailing:
                    Button(action: {
                        showingAddExpenses = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
        }
        .sheet(isPresented: $showingAddExpenses) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func expenseColor(_ amount: Int) -> Color {
        switch amount {
        case 0..<10:
            return Color.green
        case 10..<100:
            return Color.blue
        default:
            return Color.orange
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
