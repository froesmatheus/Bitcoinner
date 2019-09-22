//
//  BitcoinPrice.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 21/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct BitcoinPrice: Decodable {
    let timestamp: Date
    let price: Double
    
    init(timestamp: Date, price: Double) {
        self.timestamp = timestamp
        self.price = price
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "x"
        case price = "y"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateInMillis: TimeInterval = try container.decode(TimeInterval.self, forKey: .date)
        
        timestamp = Date(timeIntervalSince1970: dateInMillis)
        price = try container.decode(Double.self, forKey: .price)
    }
}
