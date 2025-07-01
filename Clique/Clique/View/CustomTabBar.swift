//
//  CustomTabBar.swift
//  Clique
//
//  Created by Amrita Arun on 6/27/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation { selectedTab = tab }
                    } label: {
                        if selectedTab == tab {
                            selectedTabView(icon: tab.label.icon, title: tab.label.title)
                        }
                        else {
                            if (tab.label.title == "Me") {
                                Image(tab.label.icon )
                                  .resizable()
                                  .scaledToFill()
                                  .frame(width: 27, height: 27)
                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                  .frame(maxWidth: .infinity)

                                  //.font(.system(size: 20, weight: .semibold))
                            }
                            else {
                                
                                
                                Image(systemName: tab.label.icon)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.darkGray)
                            }
                        }
                                
                        
                    }
                }
            }
       // .padding(.vertical, 8)
               .padding(.horizontal, 12)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.black)
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
    }
}

struct selectedTabView: View {
    let icon: String
    let title: String

    var body: some View {
        HStack() {
            if (title == "Me") {
                Image(icon)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 20, height: 20)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(Color.white, lineWidth: 2))
                  //.font(.system(size: 20, weight: .semibold))
            }
            else {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            
            Text(title)
                .font(.medium)
            
        }
        .padding(10)
        .background(
            Capsule(style: .circular)
                .foregroundStyle(.darkGray)
        )
        .foregroundColor(.white)
        //.padding(.vertical, 8)
        .frame(maxWidth: .infinity, maxHeight: 60)
    }
    
}

