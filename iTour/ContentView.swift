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
    @Query var destinations : [Destination]
    @State var path : [Destination]
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                ForEach(destinations){destination in
                    NavigationLink(value: destination){
                        
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
                .onDelete(perform: deleteDestination)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar{
                Button("Add Samples", action: addSamples)
                Button("Add Destination", systemImage: "plus", action: addDestination)
            }
        }
    }
    
    func addSamples(){
        let rome = Destination(name: "Rome")
        let venice = Destination(name: "Venice")
        let florence = Destination(name: "Florence")
        
        modelContext.insert(rome)
        modelContext.insert(venice)
        modelContext.insert(florence)
        try! modelContext.save()
    }
    
    func addDestination(){
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination] //TODO: ANLAT
    }
    
    func deleteDestination(_ indexSet : IndexSet){
        for index in indexSet{
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}


//
//#Preview {
//    ContentView()
//}
