//
//  moovyApp.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct moovyApp: App {
    var viewModel = AuthViewModel()
    init(){
        
        FirebaseApp.configure()
    }
    var body: some Scene {
            WindowGroup {
                ZStack{
                    ColorManager.backgroundColor
                    SplashView()
                        .environmentObject(viewModel)
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("BackgroundColor")/*@END_MENU_TOKEN@*/)
        }
    }
}
