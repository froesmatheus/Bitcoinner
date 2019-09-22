//
//  CurrentMarketPriceView.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 21/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import UIKit

final class CurrentMarketPriceView: UIView {
    @IBOutlet private(set) weak var labelCurrentPrice: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let contentView = viewFromNibForClass()
        contentView.frame = bounds
        contentView.clipsToBounds = true
        
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        setupContainerStyle()
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
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView)!
        return view
    }
}
