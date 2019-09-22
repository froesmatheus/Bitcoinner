//
//  BitcoinPriceMapper.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

final class BitcoinPriceMapper {
    static func map(from model: BitcoinPriceModel) -> BitcoinPrice {
        return BitcoinPrice(
            timestamp: model.timestamp,
            price: model.price
        )
    }

    static func map(from source: BitcoinPrice) -> BitcoinPriceModel {
        let model = BitcoinPriceModel()
        
        model.timestamp = source.timestamp
        model.price = source.price
        
        return model
    }
}
