//
//  APIManager.swift
//  iCrypto
//
//  Created by Federico on 20/03/2022.
//

import Foundation

class CryptoAPI {
    // Get your API KEY here: https://www.coinapi.io/pricing?apikey
    let API_KEY = "YOUR_KEY"
    
    func getCryptoData(currency: String, previewMode: Bool, _ completion:@escaping ([Rate]) -> ()) {
        if previewMode {
            completion(Rate.sampleRates)
            return
        }
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)?invert=false&apikey=\(API_KEY)"
        
        // Create the URL
        guard let url = URL(string: urlString) else {
            print("CryptoAPI: Invalid URL")
            return}
        
        // Attempt to retrieve data
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("CryptoAPI: Could not retrieve data...")
                return
            }
            
            // Attempt to decode the data
            do {
                let ratesData = try JSONDecoder().decode(Crypto.self, from: data)
                completion(ratesData.rates)
            } catch {
                print("CryptoAPI: \(error)")
                completion(Rate.sampleRates)
            }
        }
        .resume()
    }
}
