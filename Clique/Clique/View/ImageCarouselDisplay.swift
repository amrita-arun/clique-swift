//
//  ImageCarouselDisplay.swift
//  Clique
//
//  Created by Amrita Arun on 6/29/25.
//

import SwiftUI

struct ImageCarouselDisplay: View {
    @State private var selectedIndex = 0
     let images: [ImageResource] = [.img1, .img2, .img3]
     let colors: [Color] = [.red, .green, .blue]
    
    var body: some View {
       
    }
}

#Preview {
    ImageCarouselDisplay()
}
