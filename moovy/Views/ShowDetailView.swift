//
//  ShowDetailView.swift
//  moovy
//
//  Created by Anthony Gibah on 5/12/24.
//

import SwiftUI

struct ShowDetailView: View {
    @StateObject var viewModel: ShowDetailsViewModel
    @State private var selectedTab: Int = 0
    var imageWidth: Double = 450
    var imageHeight: Double = 250
    var imageWidthSmall: Double = 120
    var imageHeightSmall: Double = 150
    var largeText: CGFloat = 23
    var smallText: CGFloat = 15
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center){
                ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                    VStack {
                        if let image = viewModel.backdropPathImage {
                            Image(uiImage: image)
                                .resizable()
                                .cornerRadius(16)
                                .frame(width: UIScreen.main.bounds.width, height: imageHeight) // Apply corner radius directly to the image
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                        } else {
                            Image("PlaceholderImage")
                                .resizable()
                                .cornerRadius(16)
                                .frame(width: imageWidth, height: imageHeight) // Apply corner radius directly to the image
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                        }
                    }
                    HStack{
                        if let image = viewModel.posterImage {
                            Image(uiImage: image)
                                .resizable()
                                .cornerRadius(16)
                                .frame(width: imageWidthSmall, height: imageHeightSmall) // Apply corner radius directly to the image
                                .padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 0))
                        } else {
                            Image("PlaceholderImage")
                                .resizable()
                                .cornerRadius(16)
                                .frame(width: imageWidthSmall, height: imageHeightSmall) // Apply corner radius directly to the image
                                .padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 0))
                        }
                        Text("\(viewModel.showDetails?.name ?? "")")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    VStack{
                        HStack{
                            Spacer()
                            HStack{
                                Image(systemName: "star" )
                                    .foregroundColor(.ratingsColor)
                                    .font(.system(size: smallText))
                                Text(String(format: "%.1f", viewModel.showDetails?.voteAverage ?? 9.0))
                                    .font(Font.system(size: smallText, weight: .none))
                                    .foregroundColor(.ratingsColor)
                                    .padding(3)
                            }
                            .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                            .background(ColorManager.backgroundColor.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: openLink){
                                Text("Stream")
                                    .font(Font.system(size: smallText, weight: .none))
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 190, leading: 8, bottom: 10, trailing: 25))
                    
                }.onAppear {
                    Task {
                        await viewModel.loadImagePosterImage(from: viewModel.showDetails?.posterPath ?? "")
                        await viewModel.loadImageBackdropImage(from: viewModel.showDetails?.backdropPath ?? "")
                    }
                }
                HStack{
                    HStack{
                        Image(systemName: "calendar" )
                            .foregroundColor(.gray)
                            .font(.system(size: smallText))
                        Text("\(viewModel.showDetails?.firstAirDate ?? "")")
                            .font(Font.system(size: smallText, weight: .none))
                            .foregroundColor(.gray)
                    }
                    Text("|")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(.gray)
                    HStack{
                        Image(systemName: "ticket" )
                            .foregroundColor(.gray)
                            .font(.system(size: smallText))
                        Text("\(viewModel.genreName)")
                            .font(Font.system(size: smallText, weight: .none))
                            .foregroundColor(.gray)
                    }.onAppear {
                        viewModel.fetchGenreName(genreIds: viewModel.showDetails?.genreIds ?? [878], mediaType: "tv")
                    }
                    Text("|")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(.gray)
                    HStack{
                        Text("\(viewModel.showDetails?.numberOfSeasons ?? 0) \((viewModel.showDetails?.numberOfSeasons ?? 1) > 1 ? "seasons" : "season")")
                            .font(Font.system(size: smallText, weight: .none))
                            .foregroundColor(.gray)
                    }
                }.padding()
                HStack {
                    DetailsTabs(tabs:  ["About", "More Info"],
                                selectedTab: $selectedTab,
                                content: {
                        VStack{
                            Text("\(viewModel.showDetails?.overview ?? "")")
                                .font(Font.system(size: smallText, weight: .none))
                                .foregroundColor(.white)
                                .multilineTextAlignment(TextAlignment.leading)
                                .padding()
                            Spacer()
                        }.tag(0)
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(viewModel.showDetails?.productionCompanies ?? [], id: \.id) { company in
                                    ShowProductionCompanyCard(productionCompany:company, viewModel: ShowDetailsViewModel())
                                }
                            }
                        }.tag(1)
                    },
                                backgroundColor: ColorManager.backgroundColor,
                                contentColor: .backgroundColor,
                                textColor: .white,
                                activeTextColor: .white.opacity(0.8),
                                barIndicatorColor:
                                .secondaryAccentColor.opacity(0.7),
                                heightOfContent: 300)
                }
                
            }
        }
        .background(ColorManager.backgroundColor)
    }
    
    func openLink() {
        guard let url = URL(string: viewModel.showDetails?.homePage ?? "") else {
                print("Invalid URL")
                return
            }
            // Check if the device can open the URL
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
}


#Preview {
    ShowDetailView(viewModel: ShowDetailsViewModel())
}
