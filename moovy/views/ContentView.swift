//
//  ContentView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    // Dummy data to be searched
    let data = [
        "Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Honeydew"
    ]
    
    // Computed property to filter data based on search text
    var filteredData: [String] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]

        }
    
    var body: some View {
            NavigationStack {
                ZStack{
                    ColorManager.backgroundColor.edgesIgnoringSafeArea(.all)
                    List(filteredData, id: \.self) { item in
                        Text(item)
                    }
                    .navigationTitle("What do you want to watch?")
                    .searchable(text: $searchText)
                }
            }
    }
}

#Preview {
    ContentView()
}
