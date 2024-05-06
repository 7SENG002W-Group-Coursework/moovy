//
//  moovyApp.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//

import SwiftUI

@main
struct moovyApp: App {
    var body: some Scene {
            WindowGroup {
                ZStack{
                    ColorManager.backgroundColor
                    SplashView()
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("BackgroundColor")/*@END_MENU_TOKEN@*/)
        }
    }
}
