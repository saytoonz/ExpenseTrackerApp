//
//  AllTransactionsPageView.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 25/02/2023.
//

import SwiftUI

struct AllTransactionsPageView: View {
    @EnvironmentObject var transactionsListViewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                
                //MARK: - Transactions in Groups
                ForEach(Array(transactionsListViewModel.groupTransationsByMonth()), id: \.key) { month, transations in
                    
                    Section {
                        //MARK: - Transaction Lists
                        ForEach(transations) { transation in
                            TransactionRow(transaction: transation)
                        }
                        
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                    
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AllTransactionsPageView_Previews: PreviewProvider {
    
    static let transationListViewModel: TransactionListViewModel = {
       let transListVM = TransactionListViewModel()
        transListVM.transactions = transactionListPreviewData
        return transListVM
    }()
    
    static var previews: some View {
        Group {
            NavigationView{
                AllTransactionsPageView()
            }
            NavigationView{
                AllTransactionsPageView()
                    .preferredColorScheme(.dark)
            }
        }.environmentObject(transationListViewModel)
    }
}
