//
//  BitcoinRemoteDataSource.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

protocol BitcoinRemoteDataSource: BitcoinDataSource {}

final class BitcoinRemoteSource: BitcoinRemoteDataSource {
    private let getMarketPriceURL = "https://api.blockchain.info/charts/market-price"
    
    func getMarketPriceHistory(completion: @escaping BitcoinPriceCallback) {
        let url = URL(string: getMarketPriceURL)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            if let data = data, let marketResponse = try? JSONDecoder().decode(MarketPriceResponse.self, from: data) {
                DispatchQueue.main.async { completion(.success(marketResponse.values)) }
            } else {
                DispatchQueue.main.async { completion(.failure(RuntimeError("Unable to fetch response from API"))) }
            }
        }.resume()
    }
}
