//
//  HomeView.swift
//  Clique
//
//  Created by Amrita Arun on 6/27/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            GridBackground()
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack (alignment: .leading, spacing: 30) {
                    HStack {
                        Image("cliqLogo")
                        .padding(.horizontal, 40)
                        Spacer()
                        Image("notif")
                            .padding(.horizontal, 40)
                        
                    }
                    TimerStickerView()

                }
                VStack (alignment: .leading, spacing: 60){
                    
                    HomePostView()
                    HomePostView()
                }
                .padding(.top, 70)
            }
            
        }
    }
}

#Preview {
    HomeView()
}
