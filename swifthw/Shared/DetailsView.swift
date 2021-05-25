//
//  DetailsView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/20/21.
//

import SwiftUI
import Kingfisher
import youtube_ios_player_helper

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID, playerVars: ["playsinline" : 1])
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
}


struct DetailsView: View {
    
    var category:String
    var mediaID:Int
    @ObservedObject var DetailsVM = DetailsViewModel()
    @State var isDetailViewLoadedOnce = false
    @State private var showToast2: Bool = false
    @State var isBookmarked : Bool = false
//    @Binding var showToast : Bool
//    @ObservedObject var toastObs : ToastViewModel
    @State var action : String = "added to"

    var body: some View {
        
        
        ZStack {
            
            ScrollView(.vertical){
                                
                    VStack(spacing:20){
                        
                        DescSectionView(DetailsVM: self.DetailsVM)
                        
                        CastSectionView(DetailsVM: self.DetailsVM)
                        
                        ReviewSectionView(DetailsVM: self.DetailsVM)
                        
                        RecommendedCarView(title: category == "movie" ? "Recommended Movies" : "Recommended TV shows",data:DetailsVM.DescData.RecCardCarData,category:self.category,movieTextRequired:false)
//                        
                        
                }
            } .toast(isPresented: self.$showToast2){
                Text("\(DetailsVM.DescData.name) was \(action) the Watchlist ")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)}
            .padding(.horizontal,5) //spacing changed for iphone 6s (Remove 5 to restore to default : 20)
            .onAppear(){
                self.isBookmarked = DetailsVM.isInWatchList(itemToAdd: "\(category)|\(mediaID)")
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    HStack(spacing:10){
                        
                        if(!(isBookmarked)){
                            
                            Button(action:{
                                
                                DetailsVM.addToWatchlist(itemToAdd: "\(category)|\(mediaID)|\(DetailsVM.DescData.image)")
                                
                                if (!self.showToast2) {
                                    
                                    isBookmarked.toggle()
                                    action = "added to"
                                    
                                    withAnimation {
                                       self.showToast2 = true
                                   }
                               }
                                
                                    
//                                    print("bookmark-pressed")
                               
                                
                                
                            }){
                                Image(systemName: "bookmark")
    //                                .resizable()
                                    .renderingMode(.original)
                                    .font(Font.system(.body).bold())
                                    
                            }
                            
                        }
                        else{
                            
                            Button(action:{
                                
                                
                                DetailsVM.removeFromWatchlist(itemToRemove: "\(category)|\(mediaID)|\(DetailsVM.DescData.image)")
//                                print("bookmark-pressed")
                                
                                if (!self.showToast2) {

                                    isBookmarked.toggle()
                                    action = "removed from"
//                                    toastObs.toShow.title = "\(DetailsVM.DescData.name)"
//                                    toastObs.toShow.action = "removed from"

                                   withAnimation {
                                       self.showToast2 = true
                                   }
                               }
                                
                                
                            }){
                                Image(systemName: "bookmark.fill")
    //                                .resizable()
                                    .foregroundColor(.black)
//                                    .renderingMode(.original)
                                    
                                    .font(Font.system(.body).bold())
                                    
                            }
                            
                        }
                        
                        Button(action:{
                                let formattedString = "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/\(category)/\(mediaID)"
                                    guard let url = URL(string: formattedString) else { return }
                                    UIApplication.shared.open(url)
//                                    print("facebook-pressed for \(DetailsVM.DescData.name)")
                                }){
                            Image("facebook-icon")
                                .resizable()
                                .frame(width: 20, height: 20,alignment: .center)
                                
                        }
                        
                        
                        Button(action:{
                            let formattedString = "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/\(category)/\(mediaID)&hashtags=Bingeflix"
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)
                            
                            
//                            print("twitter-pressed")
                            
                        }){
                            Image("twitter-icon")
                                .resizable()
                                .frame(width: 20, height: 20,alignment: .center)
                        }
                    }
                }
                
                // This is added just as a workaround for the back button disappearing when
                // recommended movies item is clicked on
                ToolbarItem(placement: .navigationBarLeading) {
                       Text("")
                   }
         
                       
               }
            
            if DetailsVM.isDetailViewLoading{
                LoadingSpinner()
            }
            
        }.onAppear{
            if !isDetailViewLoadedOnce{
                DetailsVM.getData(category:self.category,mediaID:self.mediaID)
                isDetailViewLoadedOnce = true
            }}
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(category:"movie",mediaID:527774)
//    }
//}


struct DescSectionView: View {
        @State var isExpanded = false
        @ObservedObject var DetailsVM:DetailsViewModel
    
    var body: some View {
        
        if DetailsVM.DescData.videoID != "" && DetailsVM.DescData.videoID != "tzkWB85ULJY"{
                YTWrapper(videoID: DetailsVM.DescData.videoID).frame(width:160*2.25,height: 90*2.25)
            }
            
            //
        Text("\(DetailsVM.DescData.name)").fontWeight(.bold).font(.title).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).frame(width:360,alignment: .topLeading)
            
            HStack {
                Text("\(DetailsVM.DescData.year) | \(DetailsVM.DescData.genres)")
//                Text("|")
//                Text("\(DetailsVM.DescData.genres)")
            }.frame(width:360,alignment: .topLeading).fixedSize(horizontal: true, vertical: true)
            
            HStack {
                Image(systemName: "star.fill").foregroundColor(.red)
                Text(DetailsVM.DescData.rating+"/5.0")
            }.frame(width:360,alignment: .topLeading)
            
            Text("\(DetailsVM.DescData.overview)").font(.subheadline).frame(width:360,alignment: .topLeading)
                .fixedSize(horizontal: true, vertical: true)
                .lineLimit(isExpanded ? nil : 3)
            
            Button(action: {isExpanded.toggle()}) {
                Text(isExpanded ? "Show less" : "Show more..")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .bold()
                    //                                               .padding(.leading, 8.0)
                    .background(Color.white)
            }.offset(x:0,y:-12).frame(width:360,alignment: .bottomTrailing)
        
    }
}

struct CastSectionView: View {
    
    @ObservedObject var DetailsVM:DetailsViewModel
    
    var body: some View {
        
        
        
        Text("Cast & Crew").fontWeight(.bold).font(.system(size:25,design:.rounded)).frame(width:360,height:22,alignment: .topLeading)
//            .offset(x:0,y:-10)
        
        
        
        ScrollView(.horizontal,showsIndicators:false) {
            HStack(alignment: .top) {
                
                ForEach(DetailsVM.DescData.cast){(i) in
                    
                    VStack(alignment: .center, spacing:0){
                        KFImage(URL(string:i.image))
                            .resizable()
                            .frame(width:120*0.75,height:180*0.75)
                            .clipShape(Circle())
                        
                        Text(i.actor)
                            .offset(x:0,y:-10)
                            .font(.footnote)
                        
                        
                    }
                    .frame(height:130)
//                    .offset(x:0,y:-20)
                    
                }
            }
        }
    }
}

struct ReviewSectionView: View {
    
    @ObservedObject var DetailsVM:DetailsViewModel
    
    var body: some View {
        if(DetailsVM.DescData.reviews.count > 0){
        Text("Reviews").fontWeight(.bold).font(.system(size:25,design:.rounded)).frame(width:360,height:22,alignment: .topLeading)
        }
            
        ForEach(DetailsVM.DescData.reviews){i in
            
            ReviewCardView(name:DetailsVM.DescData.name,i: i)
            
        }
    }
}

struct ReviewCardView: View {
    var name: String
    var i : ReviewSectionData
    
    var body: some View {
        NavigationLink(destination: ReviewDetailView(title:name, author: i.author, rating: i.rating, date: i.date, content: i.content) ){
            VStack{
                
                Text("A review by \(i.author)").fontWeight(.bold).padding(.horizontal,10).font(.headline).frame(width:360,alignment:  .topLeading).fixedSize(horizontal: true, vertical: true)
                
                
                Text("Written by \(i.author) on \(i.date)").padding(.horizontal,10).font(.subheadline).foregroundColor(Color.gray).frame(width:360,alignment: .topLeading).fixedSize(horizontal: true, vertical: true)
                
                
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.red)
                        .padding(.leading,10)
                    Text(i.rating+"/5")
                }.frame(width:360,alignment: .topLeading).padding(.vertical,2)
                
                
                Text(i.content).font(.subheadline)
                    .padding(.horizontal,10)
                    .frame(width:360,alignment: .topLeading)
                    .fixedSize(horizontal: true, vertical: true)
                    .lineLimit(3)
                
                
            }}.buttonStyle(PlainButtonStyle())
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth:1)
                            .padding(EdgeInsets(top: -12, leading: 0, bottom: -12, trailing: 0))
                            .padding(.vertical,5))
    }
}
