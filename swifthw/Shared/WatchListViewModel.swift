//
//  WatchListViewModel.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/27/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class WatchlistViewModel: ObservableObject{


    @Published var watchlist  : [String]
    @Published var WatchlistItems : [WatchlistData]
//        [
//
//        WatchlistData(res:"movie|556574|https://image.tmdb.org/t/p/original/h1B7tW0t399VDjAcWJh8m87469b.jpg"),
//        WatchlistData(res:"movie|680|https://image.tmdb.org/t/p/original/x1QZHSq9AzreIVbsp8VgYemAjV0.jpg")
//    ]
    //    @Published var isDetailViewLoading = true
    

    
    
    @Published var currentItem : WatchlistData?
    
    var ItemCount:Int = 0
    
    init(){
        //
        self.WatchlistItems = [WatchlistData]()
        self.watchlist = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
    }
    
    func removeFromWatchlist(itemToRemove: String,mediaID: Int) {
        
        var watchlist1 = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        
        
        if let index = watchlist1.firstIndex(of: itemToRemove ) {
            watchlist1.remove( at :index )
            UserDefaults.standard.set(watchlist1,forKey: "watchlist")
        }
        
        if let index = WatchlistItems.firstIndex(where: { $0.mediaID == mediaID} ) {
            WatchlistItems.remove( at :index )
        }
        
  
//        print(UserDefaults.standard.object(forKey: "watchlist"))
//        print("--------------------")
        
    }

    
    func getData(curr_count:Int){
        
        let watchlist1 = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
        
//        if curr_count != ItemCount{
        
            ItemCount = 0
            self.WatchlistItems.removeAll()

            for item in watchlist1{

                let res:[String] = item.components(separatedBy: "|")
                self.WatchlistItems.append(WatchlistData(category: res[0], mediaID: (res[1] as NSString).integerValue,image:res[2]))
                ItemCount += 1
            }

//        }
        
        
//        // New item added
//        if (curr_count > ItemCount){
////            self.WatchlistItems.removeAll()
//
//            for item in watchlist{
//
//                let res:[String] = item.components(separatedBy: "|")
//                // search new item
//                if !(self.WatchlistItems.contains(where: {$0.mediaID == res[1] } )){
//                    self.WatchlistItems.append(WatchlistData(category: res[0], mediaID: res[1],image:res[2]))
//                    ItemCount += 1
//                }
////                self.WatchlistItems.append(WatchlistData(category: res[0], mediaID: res[1],image:res[2]))
//
//            }
//
//        }
//        // item deleted
//        else if(curr_count < ItemCount){
//
//        }
        
        
        
    }
    
    func isWatchlistEmpty() -> Bool {
        
        let watchlist1 = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
        return watchlist1.isEmpty
    }


}

//movie|556574|https://image.tmdb.org/t/p/original/h1B7tW0t399VDjAcWJh8m87469b.jpg,
//movie|680|https://image.tmdb.org/t/p/original/x1QZHSq9AzreIVbsp8VgYemAjV0.jpg


struct WatchlistData: Identifiable {
    var id = UUID().uuidString
//    var res:String
    var category : String
    var mediaID : Int
    var image : String
}



class ToastViewModel: ObservableObject{

    @Published var toShow : ToastContent = ToastContent(title:"",action:"none")

}

struct ToastContent: Identifiable {
    var id = UUID().uuidString
//    var res:String
    var title : String
    var action : String
    
}
