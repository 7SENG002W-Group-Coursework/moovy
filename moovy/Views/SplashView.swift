//
//  SplashView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            ColorManager.backgroundColor
            if self.isActive{
                AuthManagerView()
                    .environmentObject(viewModel)
            }else{
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
