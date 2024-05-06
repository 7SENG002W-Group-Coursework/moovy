//
//  SearchTextField.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var searchText: String
    @FocusState var isFocused
    
    var body: some View {
        HStack {
            TextField("", text: $searchText, prompt: Text("Search").foregroundColor(.gray))
                .padding(7)
                .padding(.horizontal, 25)
                .frame(width: .infinity, height: 45)
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
                    
                }
                .autocapitalization(.none)
                .keyboardType(.default)
            if isFocused{
                Button(action: {
                    searchText = ""
                    isFocused = false
                }, label: {
                    Text("Cancel")
                        .font(Font.system(size: 20, weight: .semibold))
                        .padding(5)
                })
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SearchTextField(searchText: .constant(""))
}
