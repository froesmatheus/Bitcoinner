//
//  BitcoinLocalDataSource.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import RealmSwift

protocol BitcoinLocalDataSource: BitcoinDataSource {
    func savePrices(prices: [BitcoinPrice])
    func deletePrices()
}

final class BitcoinLocalSource: BitcoinLocalDataSource {
    private let realm: Realm?
    
    init(realm: Realm? = try? .init()) {
        self.realm = realm
    }
    
    func getMarketPriceHistory(completion: @escaping BitcoinPriceCallback) {
        if let pricesModel = realm?.objects(BitcoinPriceModel.self) {
            let prices = pricesModel.map { BitcoinPriceMapper.map(from: $0) }
            completion(.success(Array(prices)))
        } else {
            completion(.failure(RuntimeError("Unable to fetch prices from local source")))
        }
    }
    
    func savePrices(prices: [BitcoinPrice]) {
        deletePrices()
        
        try? realm?.write {
            let models = prices.map { BitcoinPriceMapper.map(from: $0) }
            realm?.add(models)
        }
    }
    
    func deletePrices() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}
