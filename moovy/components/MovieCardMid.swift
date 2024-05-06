//
//  MovieCardMid.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//

import SwiftUI

struct MovieCardMid: View {
    let movie: Movie
    let index: Int
    var imageWidth: Double = 130
    var imageHeight: Double = 200
    var body: some View {
            ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                VStack {
                    Image(movie.logo)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .frame(width: imageWidth, height: imageHeight) // Apply corner radius directly to the image
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 0))
                }
                .background(ColorManager.backgroundColor)

                ZStack{
                    Text("\(index)")
                        .font(.system(size: 159, design: .monospaced))
                        .foregroundColor(.blue)
                    Text("\(index)")
                        .font(.system(size: 150, design: .monospaced))
                        .foregroundColor(ColorManager.backgroundColor)
                }
            }
            .background(Color.primary) // This sets the background color for the entire ZStack
        }
}


#Preview {
    MovieCardMid(movie: Movie(title: "Jurassic", logo: "Jurassic"), index: 2)
}
