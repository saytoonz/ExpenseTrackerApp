//
//  ContentView.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import SwiftUI
import SwiftUICharts


struct HomeView: View {
    @EnvironmentObject var transactionListViewModel: TransactionListViewModel

    var body: some View {
        
        NavigationView {
            ScrollView {
                //MARK: - Title
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //MARK: - Expenses Chat
                    
                    
                    let data = transactionListViewModel.accumulateTransactions()
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        
                        CardView{
                            VStack (alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "GHS")), type: .title, format: "GHS %..02f")
                                LineChart()
                            }.background(Color.systemBackground)
                        }
                            .data(data)
                            .chartStyle(ChartStyle(
                                backgroundColor: Color.systemBackground,
                                foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                            .frame(height: 300)
                    }
                    
                    
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
            HomeView()
            HomeView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListViewModel)

    }
}
