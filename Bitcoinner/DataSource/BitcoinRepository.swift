//
//  BitcoinRepository.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 21/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

typealias BitcoinPriceCallback = (Result<[BitcoinPrice], Error>) -> Void

final class BitcoinRepository {
    private let localSource: BitcoinLocalDataSource
    private let remoteSource: BitcoinRemoteDataSource
    
    init(
        localSource: BitcoinLocalDataSource = BitcoinLocalSource(),
        remoteSource: BitcoinRemoteDataSource = BitcoinRemoteSource()
    ) {
        self.localSource = localSource
        self.remoteSource = remoteSource
    }
    
    func fetchMarketPrice(update: Bool, completion: @escaping BitcoinPriceCallback) {
        guard !update else {
            fetchFromRemote(completion: completion)
            return
        }
        
        localSource.getMarketPriceHistory { [weak self] result in
            switch result {
            case let .success(localPrices):
                if !localPrices.isEmpty {
                    completion(.success(localPrices))
                }

                self?.fetchFromRemote(completion: completion)
            case .failure:
                self?.fetchFromRemote(completion: completion)
            }
        }
    }
    
    private func fetchFromRemote(completion: @escaping BitcoinPriceCallback) {
        remoteSource.getMarketPriceHistory { [weak self] result in
            switch result {
            case let .success(remotePrices):
                self?.localSource.savePrices(prices: remotePrices)
                
                self?.localSource.getMarketPriceHistory(completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
