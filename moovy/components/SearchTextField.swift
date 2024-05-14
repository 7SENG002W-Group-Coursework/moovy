
import SwiftUI

struct SearchTextField: View {
    @Binding var searchText: String
    @Binding var selectedTab: Int
    @StateObject var viewModel: SearchViewModel
    @FocusState var isFocused
    
    var body: some View {
        HStack {
            TextField("", text: $searchText, prompt: Text("Search").foregroundColor(.gray))
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.secondaryAccent))
                .cornerRadius(20)
                .foregroundColor(.white)
                .focused($isFocused)
                .overlay(
                    HStack {
                        Spacer().frame(maxWidth: .infinity)
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding()
                    }
                )
                .onChange(of: searchText) { oldState, newState in
                    filterString(newState, $searchText)
                }
                .autocapitalization(.none)
                .keyboardType(.default)
                .padding(.horizontal, 10)
            if isFocused{
                Button(action: {
                    searchText = ""
                    isFocused = false
                }, label: {
                    Text("Cancel")
                        .font(Font.system(size: 20, weight: .semibold))
                        .padding(5)
                        .foregroundColor(ColorManager.accentColor)
                })
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .padding(.horizontal, 15)
    }
    
    private func filterString(_ newString: String, _ binding: Binding<String>)
    {
        let filteredString = newString.filter { $0.isLetter || $0.isWhitespace || $0.isNumber  }
        
        if filteredString != newString {
                    searchText = filteredString
            }
        if selectedTab == 0{
            Task{
                await viewModel.fetchMoviesSearch(query: newString)
            }
        }else {
            Task{
                await viewModel.fetchShowsSearch(query: newString)
            }
        }
        
    }
    
}

#Preview {
    SearchTextField(searchText: .constant(""), selectedTab: .constant(0), viewModel: SearchViewModel())
}
