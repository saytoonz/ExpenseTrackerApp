//
//  ContentView.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var transactionListViewModel: TransactionListViewModel
    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Title
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    RecentTransactionsList()
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
    static let transactionListViewModel : TransactionListViewModel = {
        let transListVM = TransactionListViewModel()
        transListVM.transactions = transactionListPreviewData
        return transListVM
    }()
    
    static var previews: some View {
        Group{
            HomePageView()
            HomePageView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListViewModel)

    }
}
