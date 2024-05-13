//
//  WatchListView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import SwiftUI

struct WatchListView: View {
    @StateObject private var viewModel = WatchListViewModel()
    @EnvironmentObject var mViewModel: MovieDetailsViewModel
    @EnvironmentObject var sViewModel: ShowDetailsViewModel
    @State private var selectedTab: Int = 0
    @State var isMovieDetailPresented = false
    @State var isShowDetailPresented = false
    @State private var selectedMovie: SmallDisplay?
    @State private var selectedItem: HorizonalDisplayItem?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    DetailsTabs(tabs:  ["Movies", "Tv Shows"],
                                selectedTab: $selectedTab,
                                content: {
                        ScrollView(.vertical, showsIndicators: false) {
                            if viewModel.movieWatchListH.isEmpty {
                                placeholderViewNoResult
                            } else {
                                movieResultsView
                            }
                        }.tag(0)
                        ScrollView(.vertical, showsIndicators: false) {
                            if viewModel.showWatchListH.isEmpty {
                                placeholderViewNoResult
                            } else {
                                showResultsView
                            }
                        }.tag(1)
                    },
                                backgroundColor: ColorManager.backgroundColor,
                                contentColor: .backgroundColor,
                                textColor: .white,
                                activeTextColor: .white.opacity(0.8),
                                barIndicatorColor:
                            .secondaryAccentColor.opacity(0.7),
                                heightOfContent: UIScreen.main.bounds.height)
                }
                .navigationTitle("WatchList")
                .background(ColorManager.backgroundColor)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            .background(ColorManager.backgroundColor)
        }
    }
    
    private var movieResultsView: some View {
        ForEach(viewModel.movieWatchListH, id: \.id) { item in
            SearchItemRow(searchItem: item)
                .onTapGesture {
                    Task {
                        await viewModel.fetchMoviesFromWatchlist{ error in
                            if error == nil{
                                selectedItem = item
                            }
                        }
                        await mViewModel.fetchMovieDetails(movieId: selectedItem!.id){
                            isMovieDetailPresented = true
                        }
                    }
                }
                .sheet(isPresented: $isMovieDetailPresented) {
                    MovieDetailView(viewModel: mViewModel)
                }
        }
    }
    
    
    private var showResultsView: some View {
        ForEach(viewModel.showWatchListH, id: \.id) { item in
            SearchItemRow(searchItem: item)
                .onTapGesture {
                    Task {
                        await viewModel.fetchShowsFromWatchlist{error in
                            if error == nil || mViewModel.movieDetails != nil {
                                selectedItem = item
                            }
                        }
                        
                        await sViewModel.fetchShowDetails(showId: selectedItem!.id){
                            
                            isShowDetailPresented = true
                        }
                    }
                }
                .sheet(isPresented: $isShowDetailPresented) {
                    ShowDetailView()
                }
        }
    }
    
    private var placeholderView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer(minLength: 200)
                VStack {
                    Image("NotFoundImage")
                        .resizable()
                        .cornerRadius(16)
                        .frame(width: 120, height: 120)
                    
                    Text("Search for Movies and Tv Shows")
                        .font(Font.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
        }
    }
    
    private var placeholderViewNoResult: some View {
        HStack {
            Spacer()
            VStack {
                Spacer(minLength: 200)
                VStack {
                    Image("NotFoundImage")
                        .resizable()
                        .cornerRadius(16)
                        .frame(width: 120, height: 120)
                    
                    Text("Sorry, We Cannot Find What You Searched For :(")
                        .font(Font.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(width: 260)
                        .multilineTextAlignment(.center)
                    
                    Text("Try changing your search parameters and search again")
                        .font(Font.system(size: 17, weight: .none))
                        .foregroundColor(Color.gray)
                        .frame(width: 260)
                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    WatchListView()
}
