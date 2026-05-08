//
//  ContentView.swift
//  iTour
//
//  Created by Emirhan Gökçe on 7.05.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State var path : [Destination]
    @State var sortOrder = SortDescriptor(\Destination.name)
    @State var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path){
            DestinationListingView(sort: sortOrder, searchString: searchText)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self) { destination in
                EditDestinationView(destination: destination)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar{
                Button("Add Destination", systemImage: "plus", action: addDestination)
                
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        
                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                        
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
//    func addSamples(){
//        let rome = Destination(name: "Rome")
//        let venice = Destination(name: "Venice")
//        let florence = Destination(name: "Florence")
//        
//        modelContext.insert(rome)
//        modelContext.insert(venice)
//        modelContext.insert(florence)
//        try! modelContext.save() //Bunu yazmayınca kaydetmiyor
//    }
    
    func addDestination(){
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    

}


//
//#Preview {
//    ContentView()
//}
