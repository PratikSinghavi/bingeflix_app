//
//  LoadingSpinner.swift
//  swifthw
//
//  Created by Pratik Singhavi on 4/20/21.
//

import SwiftUI

struct LoadingSpinner: View {
    var body: some View {
        
        
        VStack {
            ZStack{
                Color(.systemBackground).ignoresSafeArea()
            
                ProgressView("Fetching Data...").progressViewStyle(CircularProgressViewStyle())
                    
                
            }
            
        }
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner()
    }
}
