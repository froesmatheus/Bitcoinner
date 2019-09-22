//
//  BitcoinPriceModel.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import RealmSwift

class BitcoinPriceModel: Object  {
    @objc dynamic var timestamp = Date()
    @objc dynamic var price = Double()
}
