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
    
    //MARK: Dışarıdan girilen kelimeyi alıp filtreleyerek[include or exclude] gösteriyor.
    
    init(sort: SortDescriptor<Destination>, searchString : String){
        _destinations = Query(filter: #Predicate{
        if searchString.isEmpty{
            return true  // Arama kutusu boşsa her şeyi göster
        }else{
            return $0.name.localizedStandardContains(searchString) //Filtrele
        }
        },sort: [sort])
    }
    /*
     .contains() = Büyük küçük harfe duyarlı, rome-> Rome bulmaz
     localizedStandardContains() = Case insensitive, Türkçe karakterler sıkıntısız çalışır,
     */
    
    func deleteDestination(_ indexSet : IndexSet){
        for index in indexSet{
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
