import SwiftUI

struct PostExpandedCarousel: View {
    /// Model for each photo/card
     /*
    struct Photo: Identifiable {
        let id = UUID()
        let name: String
        let angle: Double      // resting rotation
    }
    */

    /// Your deck of photos; the last one is on top
    @State var photos: [PostExpanded.Photo]
    
    @Binding var currentIndex: Int

    var body: some View {
        ZStack {
            ForEach(photos.indices, id: \.self) { idx in
                if idx == photos.count - 1 {
                    // Top card: draggable
                    DraggableCard(photo: photos[idx]) {
                        // when swipe completes, cycle this card to the back
                        var new = photos
                        let swiped = new.removeLast()
                        new.insert(swiped, at: 0)
                        photos = new
                        currentIndex = (currentIndex + 1) % photos.count
                    }
                } else {
                    // Underneath cards: just rotated
                    StaticCard(photo: photos[idx])
                }
            }
        }
        /*
        // Dots indicator
                   HStack(spacing: 8) {
                       ForEach(0..<photos.count, id: \.self) { idx in
                           Circle()
                               .fill(idx == currentIndex ? Color.black : Color.gray.opacity(0.4))
                               .frame(width: 8, height: 8)
                       }
                   }
         */
        //.frame(height: 320)
    }
}

struct StaticCard: View {
    let photo: PostExpanded.Photo

    var body: some View {
        Image(photo.name)
            .resizable()
            .scaledToFill()
            //.frame(width: 300, height: 320)
            .clipped()
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .rotationEffect(.degrees(photo.angle))
    }
}

struct DraggableCard: View {
    let photo: PostExpanded.Photo
    let swipeThreshold: CGFloat = 100
    var onSwipeCompleted: () -> Void

    @State private var dragOffset: CGSize = .zero
    @State private var dragRotation: Double = 0

    var body: some View {
        Image(photo.name)
            .resizable()
            .scaledToFill()
            //.frame(width: 300, height: 320)
            .clipped()
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            // resting angle
            .rotationEffect(.degrees(photo.angle))
            // live drag rotation
            .rotationEffect(.degrees(dragRotation))
            // live drag offset
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { g in
                        dragOffset = g.translation
                        dragRotation = Double(g.translation.width / 20)
                    }
                    .onEnded { g in
                        if g.translation.width > swipeThreshold {
                            // fly off to the right
                            withAnimation(.easeIn(duration: 0.2)) {
                                dragOffset = CGSize(width: 1000, height: 0)
                            }
                            // then cycle and reset
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                onSwipeCompleted()
                                dragOffset = .zero
                                dragRotation = 0
                            }
                        } else {
                            // snap back
                            withAnimation(.spring()) {
                                dragOffset = .zero
                                dragRotation = 0
                            }
                        }
                    }
            )
    }
}


