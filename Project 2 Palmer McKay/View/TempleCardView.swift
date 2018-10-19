//
//  TempleImageView.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/16/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

@IBDesignable
class TempleCardView: UIView {
    
    
    // MARK: - Properties
    var card = TempleCard()
    
    // MARK: - Computed Properties
    var cornerRadius: CGFloat { return bounds.width * 0.05 }
    var centerImageMargin: CGFloat { return bounds.width * 0.15 }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        drawBaseCard()
        drawTempleImage()
    }
    
    private func drawBaseCard() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        roundedRect.addClip()
        UIColor.white.setFill()
        UIRectFill(bounds)
    }
    
    private func drawTempleImage() {
        guard let templeImage = UIImage(named: card.filename) else {
            return
        }
        
        let width = bounds.width - 2 * centerImageMargin
        let templeImageRect = CGRect(x: centerImageMargin,
                                     y: (bounds.height - width) / 2,
                                     width: width,
                                     height: width)
        
        templeImage.draw(in: templeImageRect)
    }
}
