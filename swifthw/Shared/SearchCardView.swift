//
//  SearchCardView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/26/21.
//

import SwiftUI
import Kingfisher

struct SearchCardView: View {
    
    var details : SearchResultEntry
    
    var body: some View {
        
        NavigationLink(destination: DetailsView(category:details.category,mediaID:details.mediaID) ){
            ZStack{
                
                KFImage(URL(string:details.image))
                    .resizable()
                    .frame(width:360,height:190)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack {
                    HStack {
                        // Category
                        Text("\(details.category.uppercased())(\(details.year))" ).font(.title3).fontWeight(.bold).foregroundColor(Color.white).frame(width:180-15,alignment: .topLeading)
                        
                        
                        //Rating
                        HStack(spacing:0){
                            
                            
                            
                            Image(systemName: "star.fill").foregroundColor(.red) .font(.title3)
//                                .padding(.leading,10)
                            Text(details.rating)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        
                        }.frame(width:180-25,alignment: .topTrailing).padding(.vertical,2)
                    }.padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                    
                    Spacer()
                    
                    HStack {
                        Text(details.name).font(.title3).fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading).frame(width:280,alignment: .topLeading)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 0)).fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                       
                }


                
            }}.buttonStyle(PlainButtonStyle())
//            .padding(EdgeInsets(top: -12, leading: 0, bottom: -12, trailing: 0))
                                        .padding(.vertical,5)
                                        .frame(width: 360, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray,lineWidth:1)
//                            )
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(details:  SearchResultEntry(id:0,mediaID:399566,category: "movie",name: "Captain America: The First Avenger",rating:"4.2",image:"https://image.tmdb.org/t/p/original/yFuKvT4Vm3sKHdFY4eG6I4ldAnn.jpg",year:"2011"))
    }
}
