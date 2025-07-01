//
//  ImageCarouselV2.swift
//  Clique
//
//  Created by Amrita Arun on 6/29/25.
//

import SwiftUI

struct Item: Identifiable {
    let id: Int
    let image: ImageResource
    var offset: CGFloat = 0
    var zIndex: Double
}

struct ImageCarouselV2: View {
    @State private var selectedIndex = 0
    @Binding private var selectedCardIndex: Int
    @State private var items: [Item]
    var imageSize: CGSize
    var maximumOffset: CGFloat
    
    init(images: [ImageResource], selectedCardIndex: Binding<Int>? = nil, imageSize: CGSize = CGSize(width: 100, height: 150)) {
        var createdItems = [Item]()
        for (id, image) in images.enumerated() {
            createdItems.append(Item(id: id, image: image, zIndex: Double(images.count - 1 - id)))
        }
            
        self._selectedCardIndex = selectedCardIndex ?? .constant(0)
        self.items = createdItems
        self.imageSize = imageSize
        self.maximumOffset = imageSize.width * 0.75
        
    }
    var body: some View {
        /*
        ZStack {
            ForEach(items) { item in
                Image(item.image).resizable().scaledToFill()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(.rect(cornerRadius: imageSize.height * 0.05))
                    .overlay {
                        RoundedRectangle(cornerRadius: imageSize.height * 0.05)
                            .stroke(.white.opacity(0.20), lineWidth: 4)
                            .padding(-1.5)
                    }
                    .offset(x: item.offset)
                    .zIndex(item.zIndex)
                    .rotation3DEffect(.degrees(item.offset / maximumOffset * -25.0), axis: (x: 0.0, y: 1.0, z: 0.0)
                        
                    )
                    .rotationEffect(.degrees(item.id == selectedIndex ? (item.offset / maximumOffset * 10.0) : item.id % 2 == 0 ? (15 * 1 - (abs(items[selectedIndex].offset / maximumOffset * 10.0)))) : (-15 * (1 - (abs(items[selectedIndex].offset / maximumOffset))))), anchor: item.id % 2 == 0 ? .bottomLeading : .bottomTrailing)
                    .gesture(
                        item.id != selectedIndex ? nil : DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 0.1)) {
                                    if abs(value.translation.width) <= maximumOffset {
                                        items[selectedIndex].offset = value.translation.width
                                        withAnimation {
                                            items[selectedIndex].zIndex = Double(items.count - 1)
                                        }
                                    } else {
                                        items[selectedIndex].zIndex = 0
                                    }
                                }
                            })
                            .onEnded({ value in
                                if abs(value.translation.width) > maximumOffset {
                                    items.forEach { items[$0.id].zIndex += 1 }
                                    items[selectedIndex].zIndex = 0
                                }
                                withAnimation {
                                    items[selectedIndex].offset = .zero
                                    selectedIndex = items.first(where: { $0.zIndex == Double(items.count - 1)}?.id ?? 0, selectedCardIndex = selectedIndex
                                };)
                                }
                            })
                        )
            }
         */
        }
    }


#Preview {
    ImageCarouselV2(images: [.img1], selectedCardIndex: .constant(1), imageSize: CGSize(width: 220, height: 320))
}
