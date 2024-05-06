//
//  HomeView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedTab: Int = 0
    @State private var selectedTabB: Int = 0
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
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!, .foregroundColor: UIColor.white]

    
        }
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(viewModel.getTopMovies().enumerated()), id: \.element.id) { index, movie in
                                MovieCardMid(movie: movie, index: index + 1)
                                    .onTapGesture {
                                        // Handle tap gesture here
                                    }
                            }
                            
                        }
                        
                    }
                    
                    Text("Movies").foregroundColor(ColorManager.accentColor)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                            Tabs(tabs:  ["Now playing", "Trending", "Upcoming", "Top rated", "Popular"],
                                 selectedTab: $selectedTab,
                                 content: {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) { // Adjust spacing as needed
                                        ForEach(viewModel.getMovies(), id: \.id) { movie in
                                            MovieCard(movie: movie)
                                                .onTapGesture {
                                                }
                                        }
                                    }
                                }.tag(0)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 5) { // Adjust spacing as needed
                                        ForEach(viewModel.getMovies(), id: \.id) { movie in
                                            MovieCard(movie: movie)
                                                .onTapGesture {
                                                }
                                        }
                                    }
                                }.tag(1)
                                Text("Books").foregroundColor(.black).tag(2)
                                Text("Games").foregroundColor(.black).tag(3)
                                Text("Games").foregroundColor(.black).tag(4)
                            },
                                 backgroundColor: ColorManager.backgroundColor,
                                 contentColor: .backgroundColor,
                                 textColor: .white,
                                 activeTextColor: .white.opacity(0.8),
                                 barIndicatorColor: .secondaryAccentColor.opacity(0.7),
                            heightOfContent: 150)
                    
                    Text("Tv Shows").foregroundColor(ColorManager.accentColor)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 0))
                            Tabs(tabs:  ["Trending", "Upcoming", "Top rated", "Popular"],
                                 selectedTab: $selectedTab,
                                 content: {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) { // Adjust spacing as needed
                                        ForEach(viewModel.getMovies(), id: \.id) { movie in
                                            MovieCard(movie: movie)
                                                .onTapGesture {
                                                }
                                        }
                                    }
                                }.tag(0)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 5) { // Adjust spacing as needed
                                        ForEach(viewModel.getMovies(), id: \.id) { movie in
                                            MovieCard(movie: movie)
                                                .onTapGesture {
                                                }
                                        }
                                    }
                                }.tag(1)
                                Text("Books").foregroundColor(.black).tag(2)
                                Text("Games").foregroundColor(.black).tag(3)
                                Text("Games").foregroundColor(.black).tag(4)
                            },
                                 backgroundColor: ColorManager.backgroundColor,
                                 contentColor: .backgroundColor,
                                 textColor: .white,
                                 activeTextColor: .white.opacity(0.8),
                                 barIndicatorColor: .secondaryAccentColor.opacity(0.7),
                            heightOfContent: 150)
                    
                   
                    .navigationTitle("What do you want to watch?")
                    .searchable(text: $searchText)
                }
            }
            .background(ColorManager.backgroundColor)
        }
        
    }
    
}

#Preview {
    HomeView()
}
