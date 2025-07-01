//
//  GridBackground.swift
//  Clique
//
//  Created by Amrita Arun on 6/24/25.
//

import SwiftUI

/// A view that draws a full-screen grid of lines behind your content.
struct GridBackground: View {
    /// spacing between each grid line
    var spacing: CGFloat = 30
    /// color of the minor grid lines
    var lineColor: Color = Color.creamLine.opacity(1)
    /// width of the minor grid lines
    var lineWidth: CGFloat = 1
    
    /// (optional) every Nth line will be drawn thicker/color if non-nil
    /// 
    var majorInterval: Int? = 5
    var majorLineColor: Color = Color.gray.opacity(0)
    var majorLineWidth: CGFloat = 1
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let w = geo.size.width
                let h = geo.size.height
                
                // verticals
                var column = 0
                for x in stride(from: 0.0, through: w, by: spacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: h))
                    column += 1
                }
                
                // horizontals
                var row = 0
                for y in stride(from: 0.0, through: h, by: spacing) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: w, y: y))
                    row += 1
                }
            }
            .stroke(style: StrokeStyle(lineWidth: lineWidth))
            .foregroundColor(lineColor)
            .background(Color.cream)
            // now overlay major lines if requested
            .overlay(
                Group {
                    if let interval = majorInterval {
                        Path { path in
                            let w = geo.size.width
                            let h = geo.size.height
                            var idx = 0
                            for x in stride(from: 0.0, through: w, by: spacing) {
                                if idx % interval == 0 {
                                    path.move(to: CGPoint(x: x, y: 0))
                                    path.addLine(to: CGPoint(x: x, y: h))
                                }
                                idx += 1
                            }
                            idx = 0
                            for y in stride(from: 0.0, through: h, by: spacing) {
                                if idx % interval == 0 {
                                    path.move(to: CGPoint(x: 0, y: y))
                                    path.addLine(to: CGPoint(x: w, y: y))
                                }
                                idx += 1
                            }
                        }
                        .stroke(style: StrokeStyle(lineWidth: majorLineWidth))
                        .foregroundColor(majorLineColor)
                    }
                }
            )
        }
        .ignoresSafeArea() // draw under the status bar / edges
    }
}


#Preview {
    GridBackground()
}
