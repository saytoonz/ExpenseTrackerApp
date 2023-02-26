//
//  RecentTransactionsList.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 25/02/2023.
//

import SwiftUI

struct RecentTransactionsList: View {
    @EnvironmentObject var transactionListViewModel: TransactionListViewModel
    var body: some View {
        VStack {
            HStack{
                // MARK: - Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
//            MARK: Naviationlink
                NavigationLink {
                    AllTransactionsPageView()
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("View All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }

            }
            .padding(.top)
            
            ForEach(Array(transactionListViewModel.transactions.prefix(5).enumerated()), id: \.element) { index, transation in
                
                Divider()
                    .opacity(index == 0 ? 0 : 1)
                
                TransactionRow(transaction: transation)
                
                
            }
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        
    }
}

struct RecentTransactionsList_Previews: PreviewProvider {
   static let transactionListViewModel: TransactionListViewModel = {
        let transListVM = TransactionListViewModel()
        transListVM.transactions = transactionListPreviewData
        return transListVM
    }()
    static var previews: some View {
      Group {
            RecentTransactionsList()
            RecentTransactionsList()
                .preferredColorScheme(.dark)
        }
      .environmentObject(transactionListViewModel)
    }
}
