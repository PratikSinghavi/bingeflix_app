//
//  SearchView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/25/21.
//

import SwiftUI


struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    @ObservedObject var searchVM : SearchViewModel

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        private var searchVM : SearchViewModel
        let debouncer = Debouncer(delay: 0.5)

        init(text: Binding<String>, searchVM:SearchViewModel) {
            _text = text
            self.searchVM = searchVM
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if text.count >= 3{
//                debouncer.run( action: {
                    self.searchVM.getData(searchString: self.text)
                    
//                })
                
            }
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

           searchBar.setShowsCancelButton(true, animated: true)

        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

           searchBar.setShowsCancelButton(false, animated: true)

        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.endEditing(true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text,searchVM: searchVM)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text

    }
    
    
    
    
}

struct SearchView: View {
    
//    let cars = ["Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean"]
    @State private var searchText : String = ""
    @ObservedObject var searchVM = SearchViewModel()
    
    var body: some View {
        NavigationView {
                   
                VStack {
                    
                    
                    SearchBar(text: $searchText,placeholder: "Search Movies, TVs...",searchVM :self.searchVM)
                    
                        ScrollView{
                           
                            VStack(spacing:15){
                                
                                if searchText.count >= 3{
                                
                                    if searchVM.SearchResults.results.count > 0{
                                        ForEach(searchVM.SearchResults.results) {i in
                                            
                                            SearchCardView(details:i)
                                                                
                                         
                                        }
                                    }
                                    else{
                                        Text("No Results")
                                            .font(.title)
                                            .foregroundColor(Color.gray)
                                            .padding(.vertical)
                                    }
                                }
                            }
                           
                            
                        }.navigationBarTitle(Text("Search"))
//                        .padding(.horizontal)
                    
                    
                }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
