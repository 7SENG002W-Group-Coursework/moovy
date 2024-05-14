
import SwiftUI

struct TrendingCard: View {
    @StateObject private var viewModel = HomeViewModel()
    let trending: ResponseResult
    let index: Int
    var imageWidth: Double = 130
    var imageHeight: Double = 200
    var body: some View {
            ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                VStack {
                    if let image = viewModel.posterPathImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .frame(width: imageWidth, height: imageHeight) // Apply corner radius directly to the image
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 0))
                                } else {
                                    Image("PlaceholderImage")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(16)
                                        .frame(width: imageWidth, height: imageHeight) // Apply corner radius directly to the image
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 0))
                                }
                }
                .onAppear {
                    viewModel.loadImage(from: trending.posterPath ?? "")
                        }
                .background(ColorManager.backgroundColor)

                ZStack{
                    Text("\(index)")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                    Text("\(index)")
                        .font(.system(size: 95))
                        .foregroundColor(ColorManager.backgroundColor)
                }
            }
            .background(Color.primary) // This sets the background color for the entire ZStack
        }
}


#Preview {
    TrendingCard(trending: ResponseResult(
        id: 37854,
        title: nil,
        name: "One Piece",
        originalLanguage: "ja",
        overview: "Hello",
        posterPath: "/cMD9Ygz11zjJzAovURpO75Qg7rT.jpg",
        backdropPath: "/2rmK7mnchw9Xr3XdiTFSxTTLXqv.jpg",
        mediaType: "tv",
        adult: false,
        genreIds: [10759, 35, 16],
        popularity: 239.219,
        releaseDate: "1999-10-20",
        video: nil,
        voteAverage: 8.728,
        voteCount: 4428
    ), index: 2)
}
