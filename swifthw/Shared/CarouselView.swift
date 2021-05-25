//
//  CarouselView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/15/21.
//

import SwiftUI
import Kingfisher



struct CarouselView: View {
    
//    @ObservedObject var obs = CarouselViewModel()
    var datax : [CarouselModel]
    var category : String
    
    var body: some View {

       
//            Text(i.name)
        
        
        GeometryReader { geometry in
            ImageCarouselView(numberOfImages:datax.count){

                ForEach(datax){ i in
                
                    NavigationLink(destination: DetailsView(category:self.category,mediaID:i.mediaID)){
                ZStack {

                    KFImage(URL(string:i.image))
                        .resizable()
                        .blur(radius: 132)
                        .frame(width:geometry.size.width,height:300)
                        
//                        .blur(radius: 30)
//                        .frame(width:geometry.size.width,height:300)
//                        .clipped()
//
                        

                    KFImage(URL(string:i.image)).resizable()
                        .frame(width:geometry.size.width*0.55,height:geometry.size.height)


                }//.clipped()
                    }
                }

            }

        }.frame(height: 300, alignment: .center)
        
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(datax:[CarouselModel](),category: "movie")
    }
}

