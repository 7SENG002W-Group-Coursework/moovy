

import SwiftUI

struct ProductionCompanyCard: View {
    let productionCompany: ProductionCompany
    @EnvironmentObject var viewModel: MovieDetailsViewModel
    var largeText: CGFloat = 18
    var smallText: CGFloat = 15
    var imageHeight: CGFloat = 50
    var imageWidth: CGFloat = 150
    
    var body: some View {
        HStack{
            if let image = viewModel.posterPathImage {
                Image(uiImage: image)
                        .resizable()
                        .frame(width: imageWidth, height: imageHeight)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(16)
                        .clipped()
            }else{
                Image("PlaceholderImage")
                    .resizable()
                    .cornerRadius(16)
                    .frame(width: imageWidth, height: imageHeight)
            }
            VStack{
                HStack{
                    Text(productionCompany.name ?? "Unknown")
                        .font(Font.system(size: largeText))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "location" )
                        .foregroundColor(.ratingsColor)
                        .font(.system(size: smallText))
                    
                    Text("\(productionCompany.originCountry ?? "")")
                        .font(Font.system(size: smallText, weight: .bold))
                        .foregroundColor(Color.ratingsColor)
                    Spacer()
                }
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
        }.onAppear {
            viewModel.loadImage(from: productionCompany.logoPath ?? "")
        }
        .frame(height: imageHeight + 2)
        .padding()
        .background(ColorManager.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    ProductionCompanyCard(productionCompany: ProductionCompany(
        id: 923,
        name: "Legendary Pictures",
        originCountry: "US",
        logoPath: "/8M99Dkt23MjQMTTWukq4m5XsEuo.png"
    ))
}
