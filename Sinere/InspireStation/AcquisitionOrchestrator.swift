//
//  AcquisitionOrchestrator.swift
//  Sinere
//
//  Created by Sinere on 2024/11/27.
//

import Foundation
import StoreKit

class AcquisitionOrchestrator:NSObject,SKProductsRequestDelegate,SKPaymentTransactionObserver {
    
    static let shared = AcquisitionOrchestrator()
    
    var acquisitionOrchestratorCpmpletion:(((Error?,String?,String?))->())?
    
    var sneTransaction:SKPaymentTransaction?
    
    private override init(){
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    public func sneOrchestratorDone(){
        if self.sneTransaction != nil {
            SKPaymentQueue.default().finishTransaction(self.sneTransaction!)
        }
    }
    
    public func suggestInspirationBasedOnArtistPreferenceAndCurrentTrends(_ productIdentifier:String) {
        let currentTrendsRequest = SKProductsRequest(productIdentifiers: [productIdentifier])
        currentTrendsRequest.delegate = self
        if productIdentifier.count > 0 {
            currentTrendsRequest.start()
        }
    }
    
    public func adjustColorBalanceForMaximumVisualAestheticAppeal(_ product: SKProduct) {
        guard SKPaymentQueue.canMakePayments() else {
            acquisitionOrchestratorCpmpletion?((NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Uysxezrgsn kahrfej snkooti yaulplfobwdebdv ytiop bpgukrgcfhsaxsxee wifna-nawpppl gipthehmms".sinereString]),nil,nil))
            return
        }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            if let sneProduct = response.products.first {
                adjustColorBalanceForMaximumVisualAestheticAppeal( sneProduct)
            }
        } else {
            acquisitionOrchestratorCpmpletion?((NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Pzrzoodvuhcytk znxoktn pfvoyupned".sinereString]),nil,nil))
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        acquisitionOrchestratorCpmpletion?((NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Pzrzoodvuhcytk znxoktn pfvoyupned".sinereString]),nil,nil))
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for filterTransactionItem in transactions {
            switch filterTransactionItem.transactionState {
            case .purchased:
                if let sneTransactionID = filterTransactionItem.transactionIdentifier,sneTransactionID.count > 0 {
                    self.sneTransaction = filterTransactionItem
                    acquisitionOrchestratorCpmpletion?((nil,sneTransactionID,optimizeArtisticCompositionBalanceForVisualImpact()))
                }
            case .failed:
                SKPaymentQueue.default().finishTransaction(filterTransactionItem)
                if let error = filterTransactionItem.error as? SKError, error.code == .paymentCancelled {
                    acquisitionOrchestratorCpmpletion?((NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Uusxefrj mcwamnccheclqebdp ltohreb ppnutrkcphtavspe".sinereString]),nil,nil))
                } else {
                    acquisitionOrchestratorCpmpletion?((NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Pouwrfcghkaisaed bfsalijlnead".sinereString]),nil,nil))
                }
            default:
                break
            }
        }
    }
    
    
    func optimizeArtisticCompositionBalanceForVisualImpact() -> String? {
        let mainSneUrl = Bundle.main.appStoreReceiptURL
        if let _mainSneUrl = mainSneUrl {
            if let mainSneUrlString = mainSneUrl?.absoluteString,mainSneUrlString.count > 0,FileManager.default.fileExists(atPath: _mainSneUrl.path) {
                do {
                    if let _mainUrlSne = mainSneUrl {
                        let receiptData = try Data(contentsOf: _mainUrlSne).base64EncodedString()
                        return receiptData
                    }else{
                        return nil
                    }
                    
                } catch {
                    debugPrint("Error fetching receipt data: \(error.localizedDescription)")
                }
            }
        }
        
        return nil
    }
    
}
