//
//  PriceHistoryGraphView.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 21/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import UIKit
import Charts

final class PriceHistoryChartView: UIView {
    private(set) lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = true
        chartView.rightAxis.enabled = false
        chartView.legend.form = .line
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1)
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupXAxis()
        setupYAxis()
        
        setupContainerStyle()
        
        addSubview(chartView)
        
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupXAxis() {
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
    }
    
    private func setupYAxis() {
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.valueFormatter = CurrencyValueFormatter()
        leftAxis.labelTextColor = .black
    }
    
    private func setupContainerStyle() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:0.9, green:0.93, blue:0.95, alpha:1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
    }
}
