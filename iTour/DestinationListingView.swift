//
//  DestinationListingView.swift
//  iTour
//
//  Created by Emirhan Gökçe on 8.05.2026.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    //MARK: Önce priority, sonra name'e göre sıralıyor
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse),
                  SortDescriptor(\Destination.name)]) var destinations : [Destination]

    var body: some View {
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
    }
    
    //TODO: Burayı açıkla. özellikle neden _
    init(sort: SortDescriptor<Destination>){
        _destinations = Query(sort: [sort])
    }
    
    func deleteDestination(_ indexSet : IndexSet){
        for index in indexSet{
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name))
}
