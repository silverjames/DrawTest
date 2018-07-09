//
//  DrawView.swift
//  DrawTest
//
//  Created by Bernhard F. Kraft on 08.07.18.
//  Copyright © 2018 Bernhard F. Kraft. All rights reserved.
//

import UIKit

@IBDesignable
class DrawView: UIView {
    
    var number:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var shape:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var shading:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var color:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
//    private var diamond = UIBezierPath() { didSet {setNeedsLayout(); setNeedsDisplay()}}
    
    private func createDiamond(_ rect: CGRect) -> UIBezierPath{
        let diamond:UIBezierPath = UIBezierPath()
        diamond.move(to: getCenter(rect))
        diamond.move(to: CGPoint(x: rect.midX, y: rect.minY + cardInset(rect)))
        diamond.addLine(to: CGPoint(x: rect.maxX - cardInset(rect), y:rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y:rect.maxY - cardInset(rect)))
        diamond.addLine(to: CGPoint(x: rect.minX + cardInset(rect), y:rect.midY))
        diamond.close()
        return diamond
    }
    
    override func draw(_ rect: CGRect) {
        
//        if let context = UIGraphicsGetCurrentContext(){
        let dia = createDiamond(rect)
        UIColor.green.setFill()
        UIColor.blue.setStroke()
        dia.stroke()
        dia.fill()
    }

}

extension DrawView{
    private struct SetViewRatios {
        static let frameInsetRatio: CGFloat = 0.2
        static let maxSymbolsPerCard = 3
    }
    
    private func cardInset (_ rect: CGRect) -> CGFloat{
        return (rect.maxX + rect.maxY)/2 * SetViewRatios.frameInsetRatio
    }
    private func symbolBounds (_ bounds: CGRect) -> CGRect{
        let symbolFrame = bounds.inset(by: UIEdgeInsets.init(top: cardInset(bounds), left: cardInset(bounds), bottom: cardInset(bounds), right: cardInset(bounds)))
        return symbolFrame
    }
    private func getCenter (_ rect:CGRect) -> CGPoint{
        return CGPoint(x: rect.maxX/2, y: rect.maxY/2)
    }
}
