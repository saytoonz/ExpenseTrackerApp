//
//  TransactionListViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 25/02/2023.
//

import Foundation
import Combine

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
    
}
