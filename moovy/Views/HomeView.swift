
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var mViewModel: MovieDetailsViewModel
    @EnvironmentObject var sViewModel: ShowDetailsViewModel
    @State private var selectedTab: Int = 0
    @State private var selectedTabB: Int = 0
    @State private var selectedMovie: SmallDisplay?
    @State private var selectedTrending: ResponseResult?
    @State private var searchText = ""
    @State var isLoading = false
    @State var isMovieDetailPresented = false
    @State var isShowDetailPresented = false
    @State var isTrendingDetailPresented = false
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 25)!, .foregroundColor: UIColor.white]
        
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    if viewModel.errorOccurred {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .frame(width: 2250, height: 100)
                            .multilineTextAlignment(.center)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.allTrending, id: \.id) { trending in
                                    TrendingCard(trending: trending, index: (viewModel.allTrending.firstIndex(of: trending) ?? -1) + 1)
                                        .onTapGesture {
                                            Task {
                                                if trending.mediaType == "movie" {
                                                    await mViewModel.fetchMovieDetails(movieId: trending.id){
                                                        
                                                        selectedTrending = trending
                                                        isTrendingDetailPresented = true
                                                    }
                                                } else {
                                                    await sViewModel.fetchShowDetails(showId: trending.id){
                                                        
                                                        selectedTrending = trending
                                                        isTrendingDetailPresented = true
                                                    }
                                                }
                                            }
                                        }
                                        .sheet(isPresented: $isTrendingDetailPresented) {
                                            if selectedTrending?.mediaType == "movie" {
                                                MovieDetailView(viewModel: mViewModel)
                                            } else {
                                                ShowDetailView(viewModel: sViewModel)
                                            }
                                        }
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
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.moviesNowPlayingSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await mViewModel.fetchMovieDetails(movieId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isMovieDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isMovieDetailPresented){
                                                        MovieDetailView(viewModel: mViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(0)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.moviesTrendingSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await mViewModel.fetchMovieDetails(movieId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isMovieDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isMovieDetailPresented){
                                                        MovieDetailView(viewModel: mViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(1)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.moviesUpcomingSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await mViewModel.fetchMovieDetails(movieId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isMovieDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isMovieDetailPresented){
                                                        MovieDetailView(viewModel: mViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(2)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.moviesTopRatedSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await mViewModel.fetchMovieDetails(movieId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isMovieDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isMovieDetailPresented){
                                                        MovieDetailView(viewModel: mViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(3)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.moviesPopularSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await mViewModel.fetchMovieDetails(movieId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isMovieDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isMovieDetailPresented){
                                                        MovieDetailView(viewModel: mViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(4)
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
                    Tabs(tabs:  ["Trending", "Top rated", "Popular"],
                         selectedTab: $selectedTabB,
                         content: {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.showsTrendingSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await sViewModel.fetchShowDetails(showId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isShowDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isShowDetailPresented){
                                                        ShowDetailView(viewModel: sViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(0)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.showsTopRatedSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await sViewModel.fetchShowDetails(showId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isShowDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isShowDetailPresented){
                                                        ShowDetailView(viewModel: sViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(1)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if viewModel.errorOccurred {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(width: 250, height: 100)
                                        .multilineTextAlignment(.center)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(viewModel.showsPopularSmallDisplay, id: \.id) { data in
                                                SmallDisplayCard(smallDisplay: data)
                                                    .onTapGesture {
                                                        Task{
                                                            await sViewModel.fetchShowDetails(showId: data.id){
                                                                
                                                                selectedMovie = data
                                                                isShowDetailPresented = true
                                                            }
                                                        }
                                                    }
                                                    .sheet(isPresented: $isShowDetailPresented){
                                                        ShowDetailView(viewModel: sViewModel)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }.tag(2)
                    },
                         backgroundColor: ColorManager.backgroundColor,
                         contentColor: .backgroundColor,
                         textColor: .white,
                         activeTextColor: .white.opacity(0.8),
                         barIndicatorColor: .secondaryAccentColor.opacity(0.7),
                         heightOfContent: 150)
                    
                    
                    .navigationTitle("Trending")
                    //                    .searchable(text: $searchText)
                }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .background(ColorManager.backgroundColor)
        }
        
    }
    
}

#Preview {
    HomeView()
}
