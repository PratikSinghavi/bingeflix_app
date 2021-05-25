//
//  DropViewDelegate.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/28/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate{
    
    var watchlistdata : WatchlistData
    var watchlistVM : WatchlistViewModel
    
    
    func performDrop(info: DropInfo) -> Bool {
        
        return true
    }
    
    
    func dropEntered(info: DropInfo) {
        
        
        let fromIndex = watchlistVM.WatchlistItems.firstIndex{ (WatchlistData) -> Bool in
            return WatchlistData.id == watchlistVM.currentItem?.id
        } ?? 0
        
        
        let toIndex = watchlistVM.WatchlistItems.firstIndex{ (WatchlistData) -> Bool in
            return WatchlistData.id == self.watchlistdata.id
        } ?? 0
    
        
        if fromIndex != toIndex{
            
            withAnimation(.default){
                
                //swap items in the watchlist
                let fromItem = watchlistVM.WatchlistItems[fromIndex]
                watchlistVM.WatchlistItems[fromIndex] = watchlistVM.WatchlistItems[toIndex]
                watchlistVM.WatchlistItems[toIndex] = fromItem
                
                //swap strings in the actual watchlist
                var watchlist_fromStorage = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
                let fromString = watchlist_fromStorage[fromIndex]
                watchlist_fromStorage[fromIndex] = watchlist_fromStorage[toIndex]
                watchlist_fromStorage[toIndex] = fromString
                
                //persist
                UserDefaults.standard.set(watchlist_fromStorage,forKey: "watchlist")
                
                
            }
        }
    }
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        return DropProposal(operation: .move)
//    }
    
    
}
