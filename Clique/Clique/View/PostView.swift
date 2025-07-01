//
//  PostView.swift
//  Clique
//
//  Created by Amrita Arun on 6/22/25.
//

import SwiftUI

struct HomePostView: View {
    let lightBlue = Color("LightBlue")
    let darkBlue = Color("DarkBlue")
    let yellow = Color("Yellow")
    let green = Color("Green")
    let lightGray = Color("LightGray")
    let isSticker: Bool = false

    @State var comment: String = ""
    
    struct Photo: Identifiable {
        let id = UUID()
        let name: String       // your asset name or URL
        let size: CGSize       // desired frame
        let angle: Double      // rotation in degrees
        let offset: CGPoint    // x/y from center
    }
    
    let photos: [Photo] = [
      Photo(name: "img3", size: .init(width: 160, height: 200),
            angle: -10, offset: .init(x: -80, y: 50)),
      Photo(name: "img2", size: .init(width: 200, height: 300),
            angle: -5, offset: .init(x: 35, y: 15)),
      Photo(name: "img1", size: .init(width: 120, height: 170),
            angle: 8, offset: .init(x: 110, y: -100)),
    ]
    
    var body: some View {
        ZStack {
            //RoundedRectangle(cornerRadius: 15, style: .circular)
              //  .fill(lightBlue)
            VStack(spacing: -60) {
                ZStack (alignment: .topLeading) {
                    
                    RoundedRectangle(cornerRadius: 11, style: .circular)
                        .fill(Color.white)
                    
                    ZStack {
                        TrapezoidTab()
                            .fill(lightBlue )
                        Text("clique team <3")
                            .font(.medium)
                            .foregroundStyle(darkBlue)
                            
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
                
                ZStack {
                    ForEach(photos) { photo in
                      Image(photo.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: photo.size.width, height: photo.size.height)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                          RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                        .rotationEffect(.degrees(photo.angle))
                        .offset(x: photo.offset.x, y: photo.offset.y)
                        //.border(Color.white)
                    }
                  }
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
                                    Text("i fear it was so crazy basically all the taxis in china have cctv like crazy so they pulled us over when we were exiting one of the main cities because... More")
                                        .font(.regular)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .padding(.top, 10)
                                        .foregroundStyle(Color(.gray))
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
                                    .fill(lightGray)
                            )
                            //.padding()
                            
                    }
                    .padding(10)
                    
                    
                }
                .padding(.bottom, 15)
                .padding(.top, 30)
                .padding(.horizontal, 15)
                
               
            }
            CommentStickerView(avatar: Image("pfp"), username: "amrita", emoji: "🍓", commentText: "that sucks", stickerColor: Color("Red"), foldColor: Color("LightRed"), textBoxColor: Color("LightRed"))
                .rotationEffect(.degrees(10))
                .offset(x: 120, y: 40)
            
            Image("goodJobStickerGreen")
                .zIndex(5)
                .offset(x: -140, y: -170)
            
            
            
            
        }
        .frame(height: 650)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(lightBlue)
        )
        .padding(.horizontal, 40)
        
        
    }
}

struct TrapezoidTab: Shape {
    var cornerRadius: CGFloat = 6
    
    func path(in rect: CGRect) -> Path {
        let r = min(cornerRadius, rect.height/2)
        var p = Path()
        
        
        // 1) start bottom-left
                p.move(to: CGPoint(x: rect.minX, y: rect.maxY))

                // 2) bottom-right
                p.addLine(to: CGPoint(x: rect.maxX + 11, y: rect.maxY))

                // 3) up right-side to just below the top-right corner
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + r))

                // 4) top-right arc
                p.addArc(
                    center: CGPoint(x: rect.maxX - r, y: rect.minY + r),
                    radius: r,
                    startAngle: .degrees(0),
                    endAngle: .degrees(-90),
                    clockwise: true
                )

                // 5) across the top edge to just right of the top-left corner
                p.addLine(to: CGPoint(x: rect.minX + r, y: rect.minY))

                // 6) top-left arc
                p.addArc(
                    center: CGPoint(x: rect.minX + r, y: rect.minY + r),
                    radius: r,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(-180),
                    clockwise: true
                )

                // 7) back down left-side to close
                p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()

    
        return p
    }
}

#Preview {
    HomePostView()
}
