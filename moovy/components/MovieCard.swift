//
//  MovieCard.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    var imageWidth: Double = 110
    var imageHeight: Double = 131
    var body: some View {
            ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                VStack {
                    Image(movie.logo)
                        .resizable()
                        .cornerRadius(16)
                        .frame(width: imageWidth, height: imageHeight)
                }
                .background(ColorManager.backgroundColor)
            }
            .background(Color.primary) // This sets the background color for the entire ZStack
        }
}

#Preview {
    MovieCard(movie: Movie(movieName: "Jurassic", logo: "Jurassic"))
}
