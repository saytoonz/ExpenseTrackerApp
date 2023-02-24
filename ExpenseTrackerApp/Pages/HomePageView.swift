//
//  ContentView.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Title
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
            }.background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // MARK: - Notifications icon
                    ToolbarItem {
                         Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
            
        }
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
        HomePageView()
            .preferredColorScheme(.dark)
    }
}
