
import SwiftUI

struct AuthManagerView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var wViewModel = WatchListViewModel()
    var mViewModel = MovieDetailsViewModel()
    var sViewModel = ShowDetailsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isAuthenticated {
                ContentView()
                    .environmentObject(viewModel)
                    .environmentObject(wViewModel)
                    .environmentObject(mViewModel)
                    .environmentObject(sViewModel)
            } else {
                Login()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            Task {
                await viewModel.checkAuthentication()
            }
        }
    }  
    

}
#Preview {
    AuthManagerView()
        .environmentObject(AuthViewModel())
}
