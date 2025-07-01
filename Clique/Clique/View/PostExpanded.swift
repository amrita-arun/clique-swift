//
//  PostExpanded.swift
//  Clique
//
//  Created by Amrita Arun on 6/27/25.
//

import SwiftUI

struct PostExpanded: View {
    let isSticker: Bool = false

    @State private var currentIndex: Int = 0
    @State var comment: String = ""
    //@State var caption: String
    
    struct Photo: Identifiable {
        let id = UUID()
        let name: String       // your asset name or URL
        let angle: Double
        // x/y from center
        let caption: String
    }
    
    let photos: [Photo] = [
        Photo(name: "img3", angle: 3, caption: "This is a caption"),
        Photo(name: "img2", angle: -3, caption: "This is another caption"),
        Photo(name: "img1", angle: -1, caption: "This is yet another caption")
    ]
        
        var body: some View {
            ScrollView {
                
                
                ZStack {
                    //RoundedRectangle(cornerRadius: 15, style: .circular)
                    //  .fill(lightBlue)
                    VStack(spacing: -60) {
                        ZStack (alignment: .topLeading) {
                            
                            RoundedRectangle(cornerRadius: 11, style: .circular)
                                .fill(Color.white)
                            
                            ZStack {
                                TrapezoidTab()
                                    .fill(.lightBlue )
                                Text("clique team <3")
                                    .font(.medium)
                                    .foregroundStyle(.darkBlue)
                                
                            }
                            .frame(width: 100, height: 28)
                            .offset(x: 0, y: -43)
                            
                            
                            
                            Text("we got in trouble with the chinese communist party.")
                                .font(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(width: 200, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 17)
                        }
                        .frame(height: 150)
                        .padding(.horizontal, 15)
                        .padding(.top, 15)
                        PostExpandedCarousel(photos: self.photos, currentIndex: $currentIndex)
                            .padding(.top, 15)
                        
                        /*
                        ZStack {
                            ForEach(photos) { photo in
                                Image(photo.name)
                                    .resizable()
                                    .scaledToFill()
                                    //.frame
                                    .clipped()
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                                    .rotationEffect(.degrees(photo.angle))
                                    
                                //.border(Color.white)
                            }
                        }
                        .padding(.top, 15)
                         */
                        //.offset(y: -50)    // ← shift the whole stack up
                        //.zIndex(1)
                        // ensure the photos sit in front
                        //.zIndex(1)
                        
                        //Spacer()
                        
                        
                        ZStack (alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 11, style: .circular)
                                .fill(Color.white)
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Image(systemName: "eye")
                                        .font(.caption)
                                    
                                    
                                }
                                Text("groups / roomies / @sarahkwang")
                                    .font(.caption)
                                HStack(alignment: .top) {
                                    Image("sarahpfp")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    VStack(alignment: .leading) {
                                        Text("sarah kwang")
                                            .font(.semiBold)
                                        //.bold()
                                        HStack(alignment: .top) {
                                            /*
                                            Text("i fear it was so crazy basically all the taxis in china have cctv like crazy so they pulled us over when we were exiting the main city because they noticed we didn’t have seatbelts on. SEATBELTS like wtf... but we didn’t realize that taxis also have hella cctv inside the car so they caught us easily and bro my heart was pounding but they let us go because we were just tourists.anyway crazy bc 10 years ago i used to know china as the place where i didn’t need to wear seatbelts lol who knew")
                                             */
                                            Text(photos[currentIndex].caption)
                                                .font(.regular)
                                                .padding(.vertical, 5)
                                            //Spacer()
                                            
                                        }
                                        Spacer()
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                                TextField("Leave a note...", text: $comment)
                                //.clipShape(Capsule())
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 7)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18, style: .circular)
                                            .stroke(Color(.gray), lineWidth: 1)
                                            .fill(.lightGray)
                                    )
                                //.padding()
                                
                            }
                            .padding(10)
                            
                            
                        }
                        .padding(.bottom, 15)
                        .padding(.top, 30)
                        .padding(.horizontal, 15)
                        
                        
                    }
                    
                    
                }
                .frame(maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.lightBlue)
                )
                .padding(.horizontal, 40)
            }
            .frame(maxHeight: .infinity)
            
        
    }
}

#Preview {
    PostExpanded()
}
