//
//  WatchListView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import SwiftUI

struct WatchListView: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!, .foregroundColor: UIColor.black]
    
        }
    
    var body: some View{
        NavigationStack{
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        VStack{
                            
                            
                            
                        }
                        
                        .navigationTitle("What do you want to watch?")
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    .background(ColorManager.backgroundColor)
                }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            .background(ColorManager.backgroundColor)
    }

}

#Preview {
    WatchListView()
}
