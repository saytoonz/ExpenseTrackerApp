//
//  PreviewData.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "01/02/2023",
    institution: "EcoBank",
    account: "My Account",
    merchant: "Apple",
    amount: 1284.74,
    type: "debit",
    categoryId: 202,
    category: "Apple Store Account",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)


var transactionListPreviewData = [
    Transaction
](repeating: transactionPreviewData, count: 10)
