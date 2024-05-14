
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var mViewModel: MovieDetailsViewModel
    @EnvironmentObject var sViewModel: ShowDetailsViewModel
    @State private var selectedTab: Int = 0
    @State var isMovieDetailPresented = false
    @State var isShowDetailPresented = false
    @State private var selectedMovie: SmallDisplay?
    @State private var selectedItem: HorizonalDisplayItem?
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var refreshKey = UUID()
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 25)!, .foregroundColor: UIColor.white]
        
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    SearchTextField(searchText: $searchText, selectedTab: $selectedTab, viewModel: viewModel, isFocused: _isTextFieldFocused)
                    DetailsTabs(tabs:  ["Movies", "Tv Shows"],
                                selectedTab: $selectedTab,
                                content: {
                        ScrollView(.vertical, showsIndicators: false) {
                            if isTextFieldFocused {
                                if viewModel.searchMovieRowData.isEmpty {
                                    placeholderViewNoResult
                                } else {
                                    movieResultsView
                                }
                            } else {
                                if viewModel.searchMovieRowData.isEmpty {
                                    placeholderView
                                } else {
                                    movieResultsView
                                }
                            }
                        }.tag(0)
                        ScrollView(.vertical, showsIndicators: false) {
                            if isTextFieldFocused {
                                if viewModel.searchShowRowData.isEmpty {
                                    placeholderViewNoResult
                                } else {
                                    showResultsView
                                }
                            } else {
                                if viewModel.searchShowRowData.isEmpty {
                                    placeholderView
                                } else {
                                    showResultsView
                                }
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
                .navigationTitle(isTextFieldFocused ? "" : "Search")
                .background(ColorManager.backgroundColor)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            .background(ColorManager.backgroundColor)
        }
    }
    
    private var movieResultsView: some View {
        ForEach(viewModel.searchMovieRowData, id: \.id) { item in
            SearchItemRow(searchItem: item)
                .onTapGesture {
                    Task {
                        await mViewModel.fetchMovieDetails(movieId: item.id){
                            
                            selectedItem = item
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
        ForEach(viewModel.searchShowRowData, id: \.id) { item in
            SearchItemRow(searchItem: item)
                .onTapGesture {
                    Task {
                        await sViewModel.fetchShowDetails(showId: item.id){
                            
                            selectedItem = item
                        }
                        await sViewModel.fetchShowDetails(showId: selectedItem!.id){
                            
                            isShowDetailPresented = true
                        }
                    }
                }
                .sheet(isPresented: $isShowDetailPresented) {
                    ShowDetailView(viewModel: sViewModel)
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

// Preview provider updated for corrections
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
