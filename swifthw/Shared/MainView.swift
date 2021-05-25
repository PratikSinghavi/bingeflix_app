//
//  MainView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/13/21.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = "home"
    
    init(){
        let defaults = UserDefaults.standard
        defaults.set(25,forKey: "testvar")
    }
    
    var body: some View {
        TabView(selection:$selectedTab){
            
            // Pending Search View
            SearchView().tabItem { Label("Search",systemImage:"magnifyingglass") }.tag("search")
            
            ContentView().tabItem { Label("Home",systemImage:"house") }.tag("home")
            
            // Pending Watchlist View
            WatchListView().tabItem { Label("WatchList",systemImage:"heart") }.tag("watchlist")
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
