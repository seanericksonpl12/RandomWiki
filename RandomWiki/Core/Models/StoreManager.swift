//
//  StoreManager.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/24/22.
//

import SwiftUI
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var myProduct: SKProduct = SKProduct()
    @Published var purchaseState: SKPaymentTransactionState?
    
    var request: SKProductsRequest!
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.isEmpty { return }

        DispatchQueue.main.async {
            self.myProduct = response.products[0]
            print(self.myProduct.productIdentifier)
        }
        for invalid in response.invalidProductIdentifiers {
            print("invalid ID: \(invalid)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("request failed with error \(error.localizedDescription)")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                queue.finishTransaction(transaction)
                purchaseState = .purchased
            case .purchasing:
                purchaseState = .purchasing
            case .restored:
                purchaseState = .restored
            case .deferred, .failed:
                purchaseState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func buyProduct(product: SKProduct) {
        if !SKPaymentQueue.canMakePayments() { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func getProduct(productID: String) {
        let request = SKProductsRequest(productIdentifiers: Set([productID]))
        request.delegate = self
        request.start()
    }
    
}
