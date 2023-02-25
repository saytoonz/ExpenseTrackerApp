//
//  ContentView.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import SwiftUI
import SwiftUICharts


struct HomePageView: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]

    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Title
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //MARK: - Expenses Chat
                    CardView{
                        VStack {
                            ChartLabel("GHS 900", type: .title)
                            LineChart()
                        }.background(Color.systemBackground)
                    }
                        .data(demoData)
                        .chartStyle(ChartStyle(
                            backgroundColor: Color.systemBackground,
                            foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    
                    
                    //MARK: - Recent Transactions
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
        .accentColor(.primary)
        
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
