//
//  ContentView.swift
//  bug
//
//  Created by Krzysztof Czura on 18/09/2023.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: ListView()) {
                Text("Przejdź do listy")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .navigationBarTitle("Pierwszy Ekran")
        }
    }
}

struct ListView: View {
    @State private var items: [String] = []
    @State private var isAddingItem = false
    @State private var newItemName = ""
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .onDelete(perform: deleteItem)
        }
        .navigationBarTitle("Lista")
        .navigationBarItems(trailing:
            Button(action: {
                isAddingItem = true
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $isAddingItem) {
            AddItemView(items: $items, isPresented: $isAddingItem, newItemName: $newItemName)
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct AddItemView: View {
    @Binding var items: [String]
    @Binding var isPresented: Bool
    @Binding var newItemName: String
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Wpisz nazwę", text: $newItemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if !newItemName.isEmpty {
                        items.append(newItemName)
                        newItemName = ""
                        isPresented = false
                    }
                }) {
                    Text("Dodaj")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(newItemName.isEmpty)
            }
            .navigationBarTitle("Dodaj Rzecz")
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
