//
//  ImageCarouselView.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/13/21.
//

import SwiftUI

struct ImageCarouselView<Content: View>: View {
    
    private var numberOfImages: Int
    private var content: Content

    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    
    var body: some View {
        GeometryReader { geometry in
                   HStack(spacing: 0) {
                       self.content
                   }
                   
                   .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                   .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                   .animation(.spring())
                   .onReceive(self.timer) { _ in
                       
                    self.currentIndex = (self.currentIndex + 1) % self.numberOfImages
                   }
               }
           }
    
}

//struct ImageCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCarouselView()
//    }
//}
