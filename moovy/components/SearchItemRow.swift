
import SwiftUI

struct SearchItemRow: View {
    @StateObject private var viewModel = SearchViewModel()
    let searchItem: HorizonalDisplayItem
    var largeText: CGFloat = 23
    var smallText: CGFloat = 15
    var imageHeight: CGFloat = 150
    var imageWidth: CGFloat = 110
    var body: some View {
        HStack{
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
            VStack{
                HStack{
                    Text(searchItem.title ?? searchItem.name ?? "Unknown")
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
                    
                    Text("\(searchItem.rating ?? 0, specifier: "%.1f")")
                        .font(Font.system(size: smallText, weight: .bold))
                        .foregroundColor(Color.ratingsColor)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "ticket" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(viewModel.genreName)")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }.onAppear {
                    viewModel.fetchGenreName(genreIds: searchItem.genreIds, mediaType: searchItem.mediaType ?? "")
                }
                Spacer()
                HStack{
                    Image(systemName: "calendar" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(searchItem.releaseDate ?? "")")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "movieclapper" )
                        .foregroundColor(.white)
                        .font(.system(size: smallText))
                    
                    Text("\(searchItem.mediaType ?? "")")
                        .font(Font.system(size: smallText, weight: .none))
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            .padding()
        }.onAppear {
            viewModel.loadImage(from: searchItem.posterPath ?? "")
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
    SearchItemRow(searchItem:
                    HorizonalDisplayItem(
                        id: 841,
                        title: "Dune",
                        name: "Dune",
                        rating: 6.188,
                        genreIds: [878,
                                   12],
                        posterPath: "/9jE1U4vzlZQMvfbKWq5fj00iJBw.jpg",
                        releaseDate: "20-04-1994",
                        mediaType: "movie"
                    ))
}
