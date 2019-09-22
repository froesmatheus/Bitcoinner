//
//  BitcoinView.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import UIKit
import Charts

final class BitcoinView: UIView {
    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.refreshControl = refreshControl
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentMarketPriceView: CurrentMarketPriceView = {
        let view = CurrentMarketPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceHistoryView: PriceHistoryChartView = {
        let view = PriceHistoryChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(currentMarketPriceView)
        containerView.addSubview(priceHistoryView)
        
        setupConstraints()
    }

    func configureChart(withData data: LineChartData) {
        priceHistoryView.chartView.data = data
    }
    
    func showCurrent(price: String) {
        currentMarketPriceView.labelCurrentPrice.text = price
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        NSLayoutConstraint.activate([
            currentMarketPriceView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            currentMarketPriceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            currentMarketPriceView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            priceHistoryView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            priceHistoryView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            priceHistoryView.topAnchor.constraint(equalTo: currentMarketPriceView.bottomAnchor, constant: 10),
            priceHistoryView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            priceHistoryView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
