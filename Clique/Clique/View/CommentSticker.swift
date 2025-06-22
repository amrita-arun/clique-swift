import SwiftUI

/// 1. A tiny Shape for that folded corner
struct FoldedCorner: Shape {
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

struct StickerBase: Shape {
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
struct CommentStickerView: View {
    let avatar: Image
    let username: String
    let emoji: String
    let commentText: String
    let foldSize:Int = 25

    // customizable styling
    var stickerColor: Color = Color(red: 1.0, green: 0.8, blue: 0.8)
    var foldColor:    Color = Color(red: 1.0, green: 0.9, blue: 0.9)
    var textBoxColor: Color = Color(red: 1.0, green: 0.93, blue: 0.93)

    var body: some View {
        ZStack(alignment: .topLeading) {
            // main rounded rect
            //RoundedRectangle(cornerRadius: 16)
               // .fill(stickerColor)
            
            StickerBase(foldSize: CGFloat(self.foldSize))
                .fill(stickerColor)
                
            
            VStack(alignment: .leading, spacing: 5) {
                // header row
                HStack(spacing: 6) {
                    avatar
                      .resizable()
                      .scaledToFill()
                      .frame(width: 25, height: 25)
                      .clipShape(Circle())
                      .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Text(username)
                      .font(.semiBold)
                    //Text(emoji)
                }
                .padding(.leading, 10)
                
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 8)
                      .fill(textBoxColor)
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      //.padding(.trailing, 6)
                      //.padding(.bottom, 7)
                    Text(commentText)
                        .font(.regular)
                      .padding(5)
                      .padding(.bottom, 11)
                }
                 
                 
                // comment bubble
                
                  
            }
            .padding(8)
            //.padding(.trailing, 10)
            

            // folded corner
            FoldedCorner(size: CGFloat(self.foldSize))
                .fill(foldColor)
                .offset(x: CGFloat(self.foldSize), y: CGFloat(self.foldSize))

            
        }
        //.fixedSize() // hugs its content
        .frame(maxWidth: 120, maxHeight: 70)
    }
}

/// 3. Preview
struct CommentStickerView_Previews: PreviewProvider {
    static var previews: some View {
        CommentStickerView(
            avatar: Image("pfp"),
            username: "amrita",
            emoji: "🍓",
            commentText: "that sucks",
            stickerColor: Color("Red"),
            foldColor:    Color("LightRed"),
            textBoxColor: Color("LightRed")
        )
    }
}
