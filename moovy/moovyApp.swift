
import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct moovyApp: App {
    init(){
        
        FirebaseApp.configure()
    }
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
