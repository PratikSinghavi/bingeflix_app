//
//  ContentView.swift
//  Shared
//
//  Created by Pratik Singhavi on 4/12/21.
//

import SwiftUI
import SwiftyJSON
import Kingfisher
import Alamofire


struct ResultView: View{
    
    var choice: String
    
    var body: some View{
        Text("You chose \(choice) ")
    }
}

struct ContentView: View {
    @State private var MovieFlag = true
    @State private var isLoading = true
    @State private var showToast: Bool = false
    
    @ObservedObject var obs = CarouselViewModel()
    @ObservedObject var toastObs = ToastViewModel()
    
    var body: some View {
        
    ZStack {
            NavigationView{
            
                    ScrollView(.vertical){
                                        
                            VStack(spacing:20){
                                        
                                Text(MovieFlag ? "Now Playing":"Trending").fontWeight(.bold).font(.system(size:25,design:.rounded)).frame(width:360,height:22,alignment: .topLeading)
                                            
                                            
                                CarouselView(datax:obs.mainCarouselData,category:self.MovieFlag ? "movie":"tv")
                                            
                                TopRatedView(title: "Top Rated",data:obs.TRCardCarData,category:self.MovieFlag ? "movie":"tv",movieTextRequired:true,showToast:self.$showToast,toastObs:toastObs)
                                                
                                TopRatedView(title: "Popular",data:obs.PopCardCarData,category:self.MovieFlag ? "movie":"tv",movieTextRequired:true,showToast:self.$showToast,toastObs:toastObs)
                                    
                                            
                                        // make this clickable -> opens in safari
                                
                                VStack(spacing:0){
                                Link("Powered by TMDB ",
                                      destination: URL(string: "https://www.themoviedb.org/")!)
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)
                                
                                Text("Developed by Pratik")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)

                                }
                                
                            }
                                        
                    }.padding(.horizontal,5) //spacing changed for iphone 6s (Remove 5 to restore to default : 20)
                    .navigationBarTitle("Bingeflix")
                    .navigationBarItems(trailing: Button(action: {self.MovieFlag = !self.MovieFlag
                                        obs.switchMode(MovieTvMode: self.MovieFlag)},label:{ Text(self.MovieFlag ? "TV shows":"Movies")}))
                    .toast(isPresented: self.$showToast){
                        Text("\(toastObs.toShow.title) was \(toastObs.toShow.action) Watchlist ")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                            
                           
             }
//
            if obs.isLoading{
                LoadingSpinner()
            }
    
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


