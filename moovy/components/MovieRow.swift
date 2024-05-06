//
//  MovieRow.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    var largeText: CGFloat = 23
    var smallText: CGFloat = 15
    var imageHeight: CGFloat = 150
    var imageWidth: CGFloat = 110
    var body: some View {
        HStack{
            Image(movie.logo)
                .resizable()
                .cornerRadius(16)
                .frame(width: imageWidth, height: imageHeight)
            VStack{
                HStack{
                    Text(movie.title)
                        .font(Font.system(size: largeText))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                Spacer()
                HStack{
                    Image(systemName: "star" )
                        .foregroundColor(.ratingsColor)
                        .font(.system(size: smallText))
                    
                    Text("\(movie.rating ?? 0, specifier: "%.1f")")
                        .font(Font.system(size: smallText, weight: .bold))
                        .foregroundColor(Color.ratingsColor)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "ticket" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(movie.genre ?? "N/A")")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "calendar" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(movie.releaseYear ?? "N/A")")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "stopwatch" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(movie.runtime != nil ? movie.runtime! + " minutes" : "N/A")")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: imageHeight + 2)
        .padding()
        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .background(ColorManager.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    MovieRow(movie: Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"))
}
