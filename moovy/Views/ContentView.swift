//
//  ContentView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
// ...
      

struct ContentView: View {
    @State private var selectedNavTab: NavTab = .house
    
    init() {
        UITabBar.appearance().isHidden = true

    }
    var body: some View {
        ZStack {
                    TabView(selection: $selectedNavTab) {
                        HomeView()
                            .tag(NavTab.house)
                        SearchView()
                            .tag(NavTab.magnifyingglass)
                        WatchListView()
                            .tag(NavTab.bookmark)
                        Login()
                            .tag(NavTab.gearshape)
                    }
                    
                    VStack {
                        Spacer()
                        BottomNav(selectedNavTab: $selectedNavTab)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
    }
}

#Preview {
    ContentView()
}
