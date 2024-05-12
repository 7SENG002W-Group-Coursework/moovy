//
//  MovieCard.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

struct SmallDisplayCard: View {
    @StateObject private var viewModel = HomeViewModel()
    let smallDisplay: SmallDisplay
    var imageWidth: Double = 110
    var imageHeight: Double = 131
    var body: some View {
            ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                VStack {
                    if let image = viewModel.posterPathImage {
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(16)
                            .frame(width: imageWidth, height: imageHeight)
                                } else {
                                    Image("PlaceholderImage")
                                        .resizable()
                                        .cornerRadius(16)
                                        .frame(width: imageWidth, height: imageHeight)
                                }
                    
                }
                .onAppear {
                    viewModel.loadImage(from: smallDisplay.posterPath ?? "")
                        }
                .background(ColorManager.backgroundColor)
                .background(ColorManager.backgroundColor)
            }
            .background(Color.primary)
        
        }
}

#Preview {
    SmallDisplayCard(smallDisplay: SmallDisplay(
        id: 37854,
        posterPath: "/cMD9Ygz11zjJzAovURpO75Qg7rT.jpg"
    ))
}
