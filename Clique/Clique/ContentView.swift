//
//  ContentView.swift
//  Clique
//
//  Created by Amrita Arun on 6/22/25.
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home, friends, profile
    
    var id: String { rawValue }
    
    var label: (icon: String, title: String) { switch self {
        case .home: return ("house.fill", "Home")
        case .friends: return ("person.2.fill", "Cliques")
        case .profile: return ("pfp", "Me")
        }
    }
}
struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        ZStack {
            
            Group {
                switch selectedTab {
                case .home: HomeView()
                case .friends:
                    FriendsView()
                case .profile: ProfileView()
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
            
        }
        
        
        
        
    }
}

#Preview {
    ContentView()
}
