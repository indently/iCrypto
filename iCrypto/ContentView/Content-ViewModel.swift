//
//  Content-ViewModel.swift
//  iCrypto
//
//  Created by Federico on 20/03/2022.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 100
        
        var filteredRates: [Rate] {
            return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
        }
        
        func refreshData() {
            // Set previewMode to true when debugging to avoid using API requests
            CryptoAPI().getCryptoData(currency: "EUR", previewMode: true) { newRates in
                DispatchQueue.main.async {
                    withAnimation {
                        self.rates = newRates
                    }
                    print("Successfully got new rates: \(self.rates.count)")
                }
            }
        }
        
        func calcRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
    }
}
