//
//  DetailsViewModel.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/21/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class DetailsViewModel: ObservableObject{

//    @Published var mainCarouselData = [CarouselModel]()
//    @Published var TRCardCarData = [CardCarouselModel]()
//    @Published var PopCardCarData = [CardCarouselModel]()
    @Published var DescData : DescSectionData
    @Published var isDetailViewLoading = true
    var base_url = "https://angnodehw-309323.wl.r.appspot.com"
//    var base_url = "http://localhost:8080"
    
//    @Published var videoID = "odM92ap8_c0"
    
    init(){
        //
        self.DescData = DescSectionData(id:0,videoID: "",name: "",year:"",genres: "",overview: "",rating: "",image: "",cast:[CastSectionData](),reviews: [ReviewSectionData](),RecCardCarData: [CardCarouselModel]())
    }

    func isInWatchList(itemToAdd : String) -> Bool {
        
        let watchlist = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        
//        print(watchlist.contains(where: {$0.hasPrefix(itemToAdd)} ))
        
        return watchlist.contains(where: {$0.hasPrefix(itemToAdd)} )
    }
    
    
    func addToWatchlist(itemToAdd: String) {
        var watchlist = UserDefaults.standard.object(forKey: "watchlist") as? [String] ?? [String]()
        watchlist.append(itemToAdd)
        UserDefaults.standard.set(watchlist,forKey: "watchlist")
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
    
    func getData(category:String,mediaID:Int){
        
//        print(base_url+"/video/\(category)/\(mediaID)")
        
        AF.request(base_url+"/video/\(category)/\(mediaID)").responseData{(data) in
            
            let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
            
            self.DescData.id = 1
            self.DescData.videoID = json["videoid"].stringValue

            // Details Call
            AF.request(self.base_url+"/details/\(category)/\(mediaID)").responseData{(data) in
                
                let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
                
//                self.DescData.id = 1
                self.DescData.name = json["name"].stringValue
                self.DescData.year = json["release_date"].stringValue
                self.DescData.genres = json["genres"].stringValue
                self.DescData.rating = json["rating"].stringValue
                self.DescData.overview = json["overview"].stringValue
                self.DescData.image = json["poster_path"].stringValue
                
                // Cast Call
                AF.request(self.base_url+"/cast/\(category)/\(mediaID)").responseData{(data) in
                    
                    if(self.DescData.cast.count > 0){
                        self.DescData.cast.removeAll()
                        
                    }
                    
                    
                    
                    let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
                    self.DescData.cast.removeAll()
                    var count = 0
                    for i in json{
                        
                        
                        self.DescData.cast.append(CastSectionData(id:count
                                                                   ,actor: i.1["actor"].stringValue
                                                                   ,image: i.1["image"].stringValue
                        ))
                        count+=1
                        
                        
                       
                    }
                    
                    // Reviews Call
                    AF.request(self.base_url+"/reviews/\(category)/\(mediaID)").responseData{(data) in
                        
                        if(self.DescData.reviews.count > 0){
                            self.DescData.reviews.removeAll()
                            
                        }
                        
                        
                        let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
                        
                        count = 0
                        for i in json{
                            
                            
                            self.DescData.reviews.append(ReviewSectionData(id:count
                                                                       ,author: i.1["author"].stringValue
                                                                       ,content: i.1["content"].stringValue
                                                                       ,date: i.1["date"].stringValue
                                                                       ,rating: i.1["rating"].stringValue
                            ))
                            count+=1
                            
                            
                           
                        }
                        
                        AF.request(self.base_url+"/reco/\(category)/\(mediaID)").responseData{(data) in
                            
                            if(self.DescData.RecCardCarData.count > 0){
                                self.DescData.RecCardCarData.removeAll()
                                
                            }
                    
                            let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
                            
                            count = 0
                            for i in json{


                                self.DescData.RecCardCarData.append(CardCarouselModel(id:count
                                                            ,mediaID: i.1["id"].intValue
                                                           , year: i.1["release_date"].stringValue
                                                           ,name: i.1["name"].stringValue
                                                           ,image: i.1["image"].stringValue
                                                    ))
                                count+=1
                            }
                            
                            self.isDetailViewLoading = false
                       
//                            print(self.DescData)
                          
                        }

                    }
                    
                }
                
            }

        }
        
    }

}



struct DescSectionData: Identifiable {
    var id:Int
    var videoID: String
    var name: String
    var year : String
//    var runtime : String
    var genres : String
    var overview : String
    var rating : String
    var image : String
    var cast : [CastSectionData]
    var reviews : [ReviewSectionData]
    var RecCardCarData : [CardCarouselModel]
    
}


struct CastSectionData: Identifiable {
    var id:Int
    var actor : String
    var image : String
}


struct ReviewSectionData: Identifiable {
    var id:Int
    var author : String
    var content : String
    var date : String
    var rating : String
}
