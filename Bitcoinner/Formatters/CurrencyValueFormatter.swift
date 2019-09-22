//
//  CurrencyValueFormatter.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import Charts

public class CurrencyValueFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return value.asCurrency()
    }
}
