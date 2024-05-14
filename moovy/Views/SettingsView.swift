//
//  SettingsView.swift
//  moovy
//
//  Created by Samuel Bilewu on 5/8/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: WatchListViewModel
    @EnvironmentObject var aViewModel: AuthViewModel
    @State private var errorMessage: String = ""
    @State var isProfileSheetPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                
                HStack{
                    Text("Settings")
                        .font(.system(size: 25, weight: .bold))
                        .padding(EdgeInsets(top: 50, leading: 50, bottom: 16, trailing: 0))
                    Spacer()
                }
                .frame(width: 400, height: 36, alignment: .leading)
                .padding(.bottom, 48)
                HStack{
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 95, height: 108)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top:8, leading: 16, bottom: 8, trailing: 8))
                    VStack(alignment: .leading) {
                        Text("\(aViewModel.userProfile?.firstName ?? "John") \(aViewModel.userProfile?.lastName ?? "Doe")")
                            .frame(width: 150, alignment: .leading)
                            .padding(.top, 70)
                        
                        Text("\(aViewModel.userProfile?.email ?? "@johndoe")")
                            .frame(width: 150, alignment: .leading)
                            .font(.footnote)
                            .italic()
                            .foregroundColor(ColorManager.accentColor)
                    }.onAppear{
                        Task{
                            await aViewModel.fetchProfile{error in
                                
                            }
                            
                            await viewModel.fetchShowsFromWatchlist{error in
                                
                            }
                            
                            await viewModel.fetchMoviesFromWatchlist{error in
                                
                            }
                        }
                    }
                    Button(action: {
                        isProfileSheetPresented = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(ColorManager.tertiaryAccentColor)
                    }.padding(EdgeInsets(top:96, leading: 0, bottom: 8, trailing: 0))
                        .sheet(isPresented: $isProfileSheetPresented, onDismiss: {
                            Task {
                                await aViewModel.fetchProfile{error in
                                    
                                }
                            }
                        }) {
                            UpdateProfileView()
                        }
                }
                .frame(width: 350, height: 140, alignment: .leading)
                .background(ColorManager.secondaryAccentColor)
                .cornerRadius(10)
                .padding(EdgeInsets(top:0, leading: 20, bottom: 24, trailing: 20))
                
                HStack{
                    Spacer()
                    Image(systemName: "bookmark")
                        .foregroundColor(ColorManager.tertiaryAccentColor)
                        .padding(10)
                    
                    Text("Watchlist")
                        .frame(width: 100)
                        .padding(.trailing, 152)
                    HStack{
                        Text("\(viewModel.movieWatchListH.count + viewModel.showWatchListH.count)")
                            .frame(width: 30, height: 30)
                    }
                    .padding(1)
                    .background(ColorManager.backgroundColor.opacity(0.5))
                    .clipShape(Circle())
                    Spacer()
                    
                }
                .frame(width: 400, height: 62, alignment: .leading)
                .background(ColorManager.secondaryAccentColor)
                .padding(.bottom, -7)
                
                HStack{
                    Spacer()
                    Image(systemName: "person")
                        .foregroundColor(ColorManager.tertiaryAccentColor)
                        .padding(10)
                    
                    Text("Account")
                        .frame(width: 100)
                        .padding(.trailing, 152)
                    
                    Button(action: {
                        isProfileSheetPresented = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(ColorManager.tertiaryAccentColor)
                    }.sheet(isPresented: $isProfileSheetPresented, onDismiss: {
                        Task {
                            await aViewModel.fetchProfile{error in
                                
                            }
                        }
                    }) {
                        UpdateProfileView()
                    }
                    Spacer()
                    
                }
                .frame(width: 400, height: 62, alignment: .leading)
                .background(ColorManager.secondaryAccentColor)
                .padding(.bottom, -7)
                //
                //                HStack{
                //                    Spacer()
                //                    Image(systemName: "note.text")
                //                        .foregroundColor(ColorManager.tertiaryAccentColor)
                //                        .padding(10)
                //
                //                    Text("Privacy Policy")
                //                        .frame(width: 120)
                //                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 120))
                //
                //                    Spacer()
                //                    Spacer()
                //
                //                }
                //                .frame(width: 400, height: 62, alignment: .leading)
                //                .background(ColorManager.secondaryAccentColor)
                //                .padding(.bottom, -7)
                //
                HStack{
                    Spacer()
                    Image(systemName: "location")
                        .foregroundColor(ColorManager.tertiaryAccentColor)
                        .padding(10)
                    
                    Text("Region")
                        .frame(width: 100)
                        .padding(.trailing, 152)
                    
                    Text("uk")
                    Spacer()
                    
                }
                .frame(width: 400, height: 62, alignment: .leading)
                .background(ColorManager.secondaryAccentColor)
                .padding(.bottom, -7)
                
                if viewModel.loading {
                    
                    VStack(alignment: .leading, spacing: 5) {
                            Spinner()
                        }
                }
                
                HStack{
                    Spacer()
                    Button(action: logout) {
                        Text("Log out")
                            .font(Font.system(size: 20, weight: .none))
                            .foregroundColor(Color.white)
                            .padding(10)
                            .frame(width: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.red)
                            )
                    }.padding(20)
                    Spacer()
                }.padding(30)
                
            }.foregroundColor(.white)
            
        } // end scrollview
        //.background(ColorManager.backgroundColor)
        .background(ColorManager.backgroundColor)
        
    }
    
    private func logout() {
        Task {
            await aViewModel.signout(){ error in
                
                if error == nil{
                    aViewModel.isAuthenticated = false
                }else{
                    errorMessage = "\(String(describing: error))"
                }
                
            }
        }
    }
    
}


#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
        .environmentObject(WatchListViewModel())
}
