//
//  ContentView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

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
                        Text("Watch List")
                            .tag(NavTab.bookmark)
                        Text("Settings")
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
