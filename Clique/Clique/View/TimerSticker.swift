//
//  TimerSticker.swift
//  Clique
//
//  Created by Amrita Arun on 6/24/25.
//

import SwiftUI

struct TimerFoldedCorner: Shape {
    /// width & height of the fold
    var size: CGFloat = 30
    var r: CGFloat = 6
    

    func path(in rect: CGRect) -> Path {
        var p = Path()
        //start at top right
        
        //return p
        /*
        // create bottom arc
        p.addArc(
            center: CGPoint(x: rect.minX + size + r, y: rect.minY - size - r),
            radius: r,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
         */
        
        
        p.move(to: CGPoint(x: rect.minX - size, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY - size))
        
        p.addArc(
            center: CGPoint(x: rect.minX - r + 1, y: rect.minY - r + 1),
            radius: r,
            startAngle: .degrees(90),
            endAngle: .degrees(90),
            clockwise: true
        )
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY - size))
        p.closeSubpath()
         




        /*
        // start at top-left
        p.move(to: CGPoint(x: rect.minX, y: rect.minY + size))
        // up the left edge beyond the fold
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        // across the top edge beyond the fold
        p.addLine(to: CGPoint(x: rect.minX + size, y: rect.minY))
        // diagonal back to the start point
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + size))
        p.closeSubpath()
         */
        return p
    }
}

struct TimerStickerBase: Shape {
    /// length of the folded triangle along the top and left edges
    var foldSize: CGFloat = 24
    /// corner radius for top-right, bottom-right, bottom-left
    var cornerRadius: CGFloat = 7

    func path(in rect: CGRect) -> Path {
        let fs = min(foldSize, min(rect.width, rect.height) / 2)
        let r = min(cornerRadius, min((rect.height - fs) / 2, rect.width / 2))
        var p = Path()

        // 1) start at fold's right base
        p.move(to: CGPoint(x: rect.minX + fs, y: rect.minY))
        // 2) top edge to before top-right corner
        p.addLine(to: CGPoint(x: rect.maxX - r, y: rect.minY))
        // 3) top-right arc
        p.addArc(
            center: CGPoint(x: rect.maxX - r, y: rect.minY + r),
            radius: r,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        // 4) right edge to before bottom-right corner
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - r))
        // 5) bottom-right arc
        p.addArc(
            center: CGPoint(x: rect.maxX - r, y: rect.maxY - r),
            radius: r,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        // 6) bottom edge to before bottom-left corner
        p.addLine(to: CGPoint(x: rect.minX + r, y: rect.maxY))
        // 7) bottom-left arc
        p.addArc(
            center: CGPoint(x: rect.minX + r, y: rect.maxY - r),
            radius: r,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        // 8) left edge up to fold bottom
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + fs))
        // 9) diagonal fold back to fold apex
        p.addLine(to: CGPoint(x: rect.minX + fs, y: rect.minY + fs))
        // 10) back to fold start
        p.addLine(to: CGPoint(x: rect.minX + fs, y: rect.minY))

        p.closeSubpath()
        return p
    }
}

/// 2. The reusable comment-sticker view
struct TimerStickerView: View {
    let foldSize:Int = 35

    // customizable styling
    var stickerColor: Color = Color("TimerGray")
    var foldColor:    Color = Color("DarkGray")
   

    var body: some View {
        ZStack(alignment: .center) {
            // main rounded rect
            //RoundedRectangle(cornerRadius: 16)
               // .fill(stickerColor)
            
            StickerBase(foldSize: CGFloat(self.foldSize))
                .fill(stickerColor)
                .opacity(0.4)
            
            
            VStack(alignment: .center) {
                Spacer()
                // header row
                Text("03:15:30:22")
                    .font(.timerSemiBold)
                    .padding(.top, 15)
                    .foregroundStyle(foldColor)
                Text("until new posts arrive")
                    .font(.semiBold)
                    .padding(.bottom, 20)
                    .foregroundStyle(foldColor)
                Spacer()
                
            }
            //.padding(.leading, 10)
                
                
            FoldedCorner(size: CGFloat(self.foldSize))
                .fill(foldColor)
                .offset(x: CGFloat(self.foldSize), y: CGFloat(self.foldSize))
                .opacity(0.4)
                 
                 
                // comment bubble
                
                  
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .padding(.horizontal, 40)
            //.padding(.trailing, 10)
            

            // folded corner
            

            
        }
       
        //.fixedSize() // hugs its content
    
}


#Preview {
    TimerStickerView()
}
