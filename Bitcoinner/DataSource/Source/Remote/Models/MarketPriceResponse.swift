//
//  MarketPriceResponse.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct MarketPriceResponse: Decodable {
    let values: [BitcoinPrice]
}
