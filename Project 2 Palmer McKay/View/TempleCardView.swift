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
        static let fontName = "Palatino-Bold"
    }
    
    // MARK: - Properties
    var card = TempleCard()
    
    // MARK: - Computed Properties
    var cornerRadius: CGFloat { return bounds.width * 0.05 }
    var centerFontSize       : CGFloat { return bounds.width * 0.15 }
    var centerImageMargin: CGFloat { return bounds.width * 0.15 }
    var borderStrokeWidth : CGFloat { return 2.0 }
    var borderMargin : CGFloat { return 4.0 }
    
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
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        roundedRect.addClip()
        _ = pushContext()
        UIColor.white.setFill()
        UIRectFill(bounds)
        popContext()
    }
    
    private func drawTempleBorder() {
        let square = UIBezierPath()
        let width = bounds.width - 4
        let height = bounds.height - 4
        let borderColor : UIColor = UIColor.blue
        
        _ = pushContext()
        borderColor.setStroke()
        square.lineWidth = borderStrokeWidth
        square.move(to: CGPoint(x: borderMargin, y: borderMargin))
        square.addLine(to: CGPoint(x: width, y: borderMargin))
        square.addLine(to: CGPoint(x: width, y: height))
        square.addLine(to: CGPoint(x: borderMargin, y: height))
        square.close()
        square.stroke()
        popContext()
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
    
    private func drawTempleName() {
        let font = templeCardFont(ofSize: centerFontSize)
        let templeText = NSAttributedString(string: card.title,
            attributes: [
                .font: font,
                .foregroundColor: UIColor.yellow
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
