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
    
    // MARK: - Constants
    private struct Card {
        static let fontName = "Copperplate-Light"
    }
    
    // MARK: - Properties
    var card = TempleCard()
    
    // MARK: - Computed Properties
    var centerFontSize       : CGFloat { return bounds.width * 0.10 }
    var centerImageMargin: CGFloat { return bounds.width * 0.01 }
    var borderStrokeWidth : CGFloat { return 10.0 }
    var borderMargin : CGFloat { return 1.0 }
//    var borderMargin : CGFloat { return bounds.width * 0.15 }
    
    @IBInspectable var isStudyMode: Bool {
        get {
            return card.isStudyMode
        }
        set {
            card.isStudyMode = newValue
        }
    }
    
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
        drawTempleBorder()
        
        if isStudyMode {
            drawTempleName()
        } else {
           // don't draw temple name
        }
    }
    
    private func drawBaseCard() {
        _ = pushContext()
        UIColor.white.setFill()
        UIRectFill(bounds)
        popContext()
    }
    
    private func drawTempleBorder() {
        let square = UIBezierPath()
        let width = bounds.width 
        let height = bounds.height
        let borderColor : UIColor = UIColor.lightGray
        
        _ = pushContext()
        borderColor.setStroke()
        square.lineWidth = borderStrokeWidth
        square.move(to: CGPoint(x: 0, y: 0))
        square.addLine(to: CGPoint(x: width, y: 0))
        square.addLine(to: CGPoint(x: width, y: height))
        square.addLine(to: CGPoint(x: 0, y: height))
        square.close()
        square.stroke()
        popContext()
    }
    
    private func drawTempleImage() {
        guard let templeImage = UIImage(named: card.filename) else {
            return
        }
        
        let width = bounds.width - (2 * centerImageMargin)
        let height = bounds.height
        let templeImageRect = CGRect(x: 0,
                                     y: 0,
                                     width: width,
                                     height: height)
        
        templeImage.draw(in: templeImageRect)
    }
    
    private func drawTempleName() {
        let font = templeCardFont(ofSize: centerFontSize)
        let templeText = NSAttributedString(string: card.title,
            attributes: [
                .font: font,
                .foregroundColor: UIColor.black,
                .backgroundColor: UIColor.init(white: 1.0, alpha: 0.7)
            ])
        var textBounds = CGRect.zero
        
        textBounds.size = templeText.size()
        textBounds.origin = CGPoint(x: (bounds.width - textBounds.width) / 2,
                                    y: (bounds.height - textBounds.height) / 1.2)
        templeText.draw(in: textBounds)
        
    }
    
    // MARK: - Helpers
    
    private func popContext() {
        UIGraphicsGetCurrentContext()?.restoreGState()
    }
    
    private func pushContext() -> CGContext? {
        let context = UIGraphicsGetCurrentContext()
        
        context?.saveGState()
        
        return context
    }
    
    private func templeCardFont(ofSize fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: Card.fontName, size: fontSize) {
            return font
        }
        
        return UIFont.preferredFont(forTextStyle: .body)
    }
}
