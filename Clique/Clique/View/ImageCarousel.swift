//
//  ImageCarousel.swift
//  Clique
//
//  Created by Amrita Arun on 6/29/25.
//

import SwiftUI

struct Photo: Identifiable {
    let id = UUID()
    let name: String       // your asset name or URL
    let angle: Double
    let caption: String
    // x/y from center
}

let photos: [Photo] = [
    Photo(name: "img3", angle: 5, caption: "This is a sample caption"),
    Photo(name: "img2", angle: -5, caption: "Another sample caption"),
    Photo(name: "img1", angle: -1, caption: "Yet another sample caption")
]

struct ImageCarousel: View {
    //@Environment(Store.self) private var store
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            LazyHStack(spacing: 30) {
                ForEach(photos) { photo in
                    VStack {
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 400, maxHeight: 600)
                            .clipped()
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            .rotationEffect(.degrees(photo.angle))
                        
                        
                        Text(photo.caption)
                            .font(.title)
                    }
                    .containerRelativeFrame(.horizontal)
                    .scrollTransition(.animated, axis: .horizontal) {
                        content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.6)
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                            .rotationEffect(Angle(degrees: phase.isIdentity ? 0 : 30.0))
                    }
                }
            }
        }
        //.frame(maxWidth: 500, maxHeight: .infinity)
    }
}

#Preview {
    ImageCarousel()
}
