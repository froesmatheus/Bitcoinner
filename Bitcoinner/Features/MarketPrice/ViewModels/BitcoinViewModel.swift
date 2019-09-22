//
//  MarketPriceViewModel.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 21/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import Charts

final class BitcoinViewModel {
    private let repository: BitcoinRepository
    
    var startLoading: (() -> Void)?
    var endLoading: (() -> Void)?
    var configureChartData: ((LineChartData) -> Void)?
    var showMostRecentPrice: ((String) -> Void)?
    
    init(repository: BitcoinRepository = .init()) {
        self.repository = repository
    }
    
    func fetchMarketPrice(update: Bool = false) {
        if !update {
            startLoading?()
        }
        
        repository.fetchMarketPrice(update: update) { [weak self] result in
            switch result {
            case let .success(prices):
                self?.endLoading?()

                let sortedPrices = prices.sorted(by: { $0.timestamp < $1.timestamp })
                self?.configureChartData(withPrices: sortedPrices)
                
                if let mostRecentPrice = sortedPrices.last {
                    self?.showMostRecentPrice?(mostRecentPrice.price.asCurrency())
                }
            case .failure:
                self?.endLoading?()
            }
        }
    }
    
    private func configureChartData(withPrices prices: [BitcoinPrice]) {
        let entries = prices
            .map { price -> ChartDataEntry in
                return ChartDataEntry(x: price.timestamp.timeIntervalSince1970, y: price.price)
            }

        let dataSet = BitcoinDataSet(prices: entries)
        let data = LineChartData(dataSet: dataSet)
        
        configureChartData?(data)
    }
}
