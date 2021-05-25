//
//  TopRatedView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/14/21.
//

import SwiftUI
import Kingfisher

struct TopRatedView: View {
    
    var title : String
    var data:[CardCarouselModel]
    var category : String
    var movieTextRequired: Bool
    var init_watchlist = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
    //.contains(where: {$0.hasPrefix("\(category)|\(i.mediaID)")} )
    @Binding var showToast : Bool
    var toastObs : ToastViewModel

    var body: some View {
        

        
        VStack(spacing:20) {
            Text("\(title)").fontWeight(.bold).font(.system(size:25,design:.rounded)).padding(.bottom).frame(width:360,height:22,alignment: .topLeading)
            
            
            
            ScrollView(.horizontal){
                
                HStack(alignment:.top,spacing:10){
                    
                    ForEach(data){ i in
                        NavigationLink(destination: DetailsView(category:self.category,mediaID:i.mediaID) ){
                            VStack(alignment:.leading,spacing:0){
                            
                                KFImage(URL(string:i.image)).resizable()
                                .frame(width:105,height:160)
        //                        .background(Color.red)
                                .cornerRadius(12)
                                
                                if movieTextRequired{
                                Text(i.name)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding([.top, .leading, .trailing],5)
                                    .frame(width:105)
                                
                                Text("(\(i.year))")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(width:105,height:20)
                                }
                            }
                            .background(Color.white)
                            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .contextMenu {
                                contextView(i:i,isPresent: init_watchlist.contains(where: {$0.hasPrefix("\(category)|\(i.mediaID)")}),showToast: self.$showToast ,category:category,toastObs : toastObs)
                            }
                        }.buttonStyle(PlainButtonStyle())
                        
                    
                    
                    Spacer()
                    
                    }
            }
        }
    }
}

//struct TopRatedView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopRatedView(title:"Top Rated")
//    }
//}

struct contextView: View {
    
    var i : CardCarouselModel
//    @Observed var watchlist = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]().contains(where: {$0.hasPrefix("\(category)|\(i.mediaID)")} )
    @State var isPresent : Bool
    @Binding var showToast : Bool
    var category: String
    var toastObs : ToastViewModel
  
    func isInWatchList(itemToAdd : String,isPresent:Bool) -> Bool {
        
        let watchlist1 = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        
//        print(watchlist1.contains(where: {$0.hasPrefix(itemToAdd)} ))
//        print("isPresent:\(isPresent)")
        
        return watchlist1.contains(where: {$0.hasPrefix(itemToAdd)} )
    }
    
    func addToWatchlist(itemToAdd: String) {
        var watchlist1 = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        watchlist1.append(itemToAdd)
        UserDefaults.standard.set(watchlist1,forKey: "watchlist")
//        print(UserDefaults.standard.object(forKey: "watchlist"))
//        print("--------------------")
        
    }
    
    func removeFromWatchlist(itemToRemove: String) {
        
        var watchlist = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        
        
        if let index = watchlist.firstIndex(of: itemToRemove ) {
            watchlist.remove( at :index )
        }
        
        
        UserDefaults.standard.set(watchlist,forKey: "watchlist")
//        print(UserDefaults.standard.object(forKey: "watchlist"))
//        print("--------------------")
        
    }
    
    
    var body: some View {
        VStack{
            
            if(
                !isPresent || !(isInWatchList(itemToAdd: "\(category)|\(i.mediaID)",isPresent: isPresent))
            ){
                Button(action:{
                    
                    
                    addToWatchlist(itemToAdd: "\(category)|\(i.mediaID)|\(i.image)")
                    isPresent = true
                    
                    if (!self.showToast) {
                        toastObs.toShow.title = "\(i.name)"
                        toastObs.toShow.action = "added to"

                       withAnimation {
                           self.showToast = true
                       }
                   }
                    
                }){
                    HStack{
                        Text("Add to watchList")
                        Image(systemName: "bookmark")
                    }
                }
            }
            else if( isPresent || isInWatchList(itemToAdd: "\(category)|\(i.mediaID)",isPresent: isPresent) )
            {
                Button(action:{
                    
                    
                    removeFromWatchlist(itemToRemove: "\(category)|\(i.mediaID)|\(i.image)")
                    isPresent = false
                    
                    // Toast
                    if (!self.showToast) {

                        toastObs.toShow.title = "\(i.name)"
                        toastObs.toShow.action = "removed from"

                       withAnimation {
                           self.showToast = true
                       }
                   }
                    
                }){
                    HStack{
                        Text("Remove from watchList")
                        Image(systemName: "bookmark.fill")
                    }
                }
            }
            
            //  Button 2
            Button(action:{
                let formattedString = "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/\(category)/\(i.mediaID)"
                guard let url = URL(string: formattedString) else { return }
                UIApplication.shared.open(url)
                
            }){
                HStack{
                    Text("Share on Facebook")
                    Image("facebook-icon")
                }
            }
            
            // Button 3
            Button(action:{let formattedString = "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/\(category)/\(i.mediaID)&hashtags=CSCI571USCFilms"
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)}){
                HStack{
                    Text("Share on Twitter")
                    Image("twitter-icon")
                }
            }
            
            
            
        }.onAppear{
            isPresent = (isInWatchList(itemToAdd: "\(category)|\(i.mediaID)",isPresent: isPresent))
        }
    }
}
}


