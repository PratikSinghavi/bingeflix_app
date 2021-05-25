//
//  SearchViewModel.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/25/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class SearchViewModel: ObservableObject{


    @Published var SearchResults : SearchResultData
//    var base_url = "https://angnodehw-309323.wl.r.appspot.com"
    var base_url = "http://localhost:8080"
    
    
    init(){
        //
        self.SearchResults = SearchResultData(id:0,results:[SearchResultEntry]())
    }

    
    func getData(searchString:String){
        
//        print("current String : \(searchString)")
        
//        print("http://localhost:8080/search/\(searchString)")
        let url = String(self.base_url+"/search/" + "\(searchString)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
//        print(url)
        
        AF.request(url).validate() .responseData {(data) in
            
            let json = try! JSON(data:data.data!) // JSON part is from SwiftyJSON
            
            self.SearchResults.results.removeAll()
            
            var count = 0
            for i in json{


                self.SearchResults.results.append(SearchResultEntry(id:count
                                            ,mediaID: i.1["id"].intValue
                                            ,category: i.1["category"].stringValue
                                            ,name: i.1["name"].stringValue
                                            ,rating:i.1["rating"].stringValue
                                            ,image: i.1["image"].stringValue
                                            ,year : i.1["release_date"].stringValue
                                    ))
                count+=1
            }
            
//            print(self.SearchResults)
            
        }
        
    }

}

struct SearchResultData: Identifiable {
    var id:Int
    var results : [SearchResultEntry]
}



struct SearchResultEntry: Identifiable {
    var id:Int
    var mediaID : Int
    var category : String
    var name : String
    var rating : String
    var image : String
    var year: String
}
