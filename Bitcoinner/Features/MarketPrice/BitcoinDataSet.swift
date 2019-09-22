//
//  BitcoinDataSet.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import Charts

final class BitcoinDataSet: LineChartDataSet {
    convenience init(prices: [ChartDataEntry]) {
        self.init(entries: prices, label: nil)
        
        axisDependency = .left
        setColor(UIColor(named: "PrimaryColor")!)
        lineWidth = 1
        drawCirclesEnabled = false
        drawValuesEnabled = false
        highlightEnabled = false
    }
}
