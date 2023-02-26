//
//  ExpenseTrackerAppApp.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import SwiftUI

@main
struct ExpenseTrackerAppApp: App {
   
     @StateObject var transactionListViewModel = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(transactionListViewModel)
        }
    }
}
