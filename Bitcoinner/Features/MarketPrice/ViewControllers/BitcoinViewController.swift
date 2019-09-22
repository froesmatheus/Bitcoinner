//
//  BitcoinViewController.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 19/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import UIKit

final class BitcoinViewController: UIViewController {
    private lazy var bitcoinView: BitcoinView = {
        let view = BitcoinView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: BitcoinViewModel
    
    init(viewModel: BitcoinViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupBaseView()
        setupNavigationBar()
        bindViewModel()
        setupRefreshControl()
        
        viewModel.fetchMarketPrice()
    }
    
    private func setupRefreshControl() {
        bitcoinView.refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc private func pullToRefresh() {
        viewModel.fetchMarketPrice(update: true)
    }
    
    private func setupBaseView() {
        view.addSubview(bitcoinView)
        
        NSLayoutConstraint.activate([
            bitcoinView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bitcoinView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bitcoinView.topAnchor.constraint(equalTo: view.topAnchor),
            bitcoinView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
 
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.barTintColor = UIColor(named: "PrimaryColor")
        title = "Bitcoinner"
    }
    
    private func bindViewModel() {
        viewModel.startLoading = { [unowned self] in
            self.loadingView.startLoading(inView: self.view)
        }
        
        viewModel.endLoading = { [unowned self] in
            self.loadingView.stopLoading()
            self.bitcoinView.refreshControl.endRefreshing()
        }
        
        viewModel.configureChartData = { [unowned self] data in
            self.bitcoinView.configureChart(withData: data)
        }
        
        viewModel.showMostRecentPrice = { [unowned self] price in
            self.bitcoinView.showCurrent(price: price)
        }
    }
}
