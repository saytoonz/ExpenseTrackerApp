//
//  TransactionListViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 25/02/2023.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
     
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        getTransactions()
    }
    
    
    
    //MARK: - Get All Transactions with URL
    func getTransactions() {
        guard
            let url = URL(string: "https://designcode.io/data/transactions.json")
        else{
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response)  -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                    
                case .failure(let error):
                    print("Error fetching transactions ", error.localizedDescription)
                    
                case .finished:
                    print("Finised fetchig transactions")
                }
                
            } receiveValue: { [weak self] transactionsResult in
                self?.transactions = transactionsResult
            }
            .store(in: &cancellables)
        
    }
    
    
    //MARK: Group transactions for the all transactions page
    func groupTransationsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {
            return [:]
        }
       return TransactionGroup(grouping: transactions) { $0.mount }
    }
    
    //MARK: Tople data for the expenses chat
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else {
            return []
        }
        
        let today = "02/17/2022".dateParsed() //Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum:Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter { $0.dateParsed  == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2dp()
            cumulativeSum.append((date.formatted(), sum))
        }
        
        return cumulativeSum
        
    }

    
}
