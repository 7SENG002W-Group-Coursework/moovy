//
//  SearchView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//
//https://www.swiftyplace.com/blog/swiftui-search-bar-best-practices-and-examples
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 25)!, .foregroundColor: UIColor.white]
        
    }
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    SearchTextField(searchText: $searchText, isFocused: _isTextFieldFocused)
                    if isTextFieldFocused{
                        if viewModel.getSearchResults().isEmpty{
                            placeholderViewNoResult
                        }
                        else{
                            resultsView
                        }
                    }else{
                        if viewModel.getSearchDefaults().isEmpty{
                            placeholderView
                        }
                        else{
                            defaultsView
                        }
                    }
                }
                .navigationTitle(isTextFieldFocused ? "" : "Search")
                .background(ColorManager.backgroundColor)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            .background(ColorManager.backgroundColor)
        }
    }
    
    
        private var resultsView: some View {
            ForEach(viewModel.getSearchResults(), id: \.id) { movie in
                MovieRow(movie: movie)
            }
        }

        private var defaultsView: some View {
            ForEach(viewModel.getSearchDefaults(), id: \.id) { movie in
                MovieRow(movie: movie)
            }
        }

    
        private var placeholderView: some View {
            HStack{
                Spacer()
                VStack{
                    Spacer(minLength: 200)
                    VStack{
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
            HStack{
                Spacer()
                VStack{
                    Spacer(minLength: 200)
                    VStack{
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
    SearchView()
}
