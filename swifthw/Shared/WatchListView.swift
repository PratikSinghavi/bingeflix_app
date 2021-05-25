//
//  WatchListView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/27/21.
//

import SwiftUI
import Kingfisher

struct WatchListView: View {
    
//    @State var watchlist = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
    @StateObject var watchlistVM = WatchlistViewModel()
    
    @Namespace var animation
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
        
    ]
    
    
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                ScrollView{
                    LazyVGrid(columns: layout, spacing: 3) {
                        ForEach(watchlistVM.WatchlistItems){ i in
                                
                            NavigationLink(destination: DetailsView(category:i.category,mediaID:i.mediaID)){
                                
//                                RemoteImage(url:i.image)
                                KFImage(URL(string:i.image))
                                .resizable()
                                .frame(width:120,height:180)
                                .onDrag({
                                        
                                        watchlistVM.currentItem = i
                                        
                                        return NSItemProvider(contentsOf: URL(string:"\(i.id)")!)!
                                    })
                                .onDrop(of: [.url], delegate: DropViewDelegate(watchlistdata: i, watchlistVM: watchlistVM))
                                .contextMenu{
                                
                                        Button(action:{
                                            watchlistVM.removeFromWatchlist(itemToRemove: "\(i.category)|\(i.mediaID)|\(i.image)",mediaID: i.mediaID)
        //                                    isPresent = true
                                        }){
                                            HStack{
                                                Text("Remove from watchList")
                                                Image(systemName: "bookmark.fill")
                                            }
                                        }
                                }
                                
                                
                                }.buttonStyle(PlainButtonStyle())
                                

                      }
                    
                        
                    }
                }.padding(.horizontal,5) //spacing changed for iphone 6s (Remove 5 to restore to default : 20)
                .navigationBarTitle(Text("Watchlist"))
                .onAppear(){
                    let watchlist = UserDefaults.standard.object(forKey: "watchlist")  as? [String] ?? [String]()
                    watchlistVM.getData(curr_count:watchlist.count)
            }
                
                if (watchlistVM.isWatchlistEmpty()){
                    Text("Watchlist is empty")
                        .font(.title)
                        .foregroundColor(Color.gray)
                }
                
                
            }
            
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}



struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
//movie|556574|https://image.tmdb.org/t/p/original/h1B7tW0t399VDjAcWJh8m87469b.jpg,
//movie|680|https://image.tmdb.org/t/p/original/x1QZHSq9AzreIVbsp8VgYemAjV0.jpg
