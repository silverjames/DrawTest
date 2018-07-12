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
    
    @IBInspectable
    var number:Int = 3 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var shape:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var shading:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var color:Int = 0 { didSet {setNeedsLayout(); setNeedsDisplay()}}

    //    private var diamond = UIBezierPath() { didSet {setNeedsLayout(); setNeedsDisplay()}}
    
    private func createDiamond(_ rect: CGRect) -> UIBezierPath{
        let diamond = UIBezierPath()
        let axis = (min(rect.width, rect.height) * 0.9)/2
        let center = getCenter(rect)
        let p1 = CGPoint(x: center.x, y: center.y - axis)
        let p2 = CGPoint(x: center.x + axis, y: center.y)
        let p3 = CGPoint(x: center.x, y: center.y + axis)
        let p4 = CGPoint(x: center.x - axis, y: center.y)
        diamond.move(to: p1)
        diamond.addLine(to: p2)
        diamond.addLine(to: p3)
        diamond.addLine(to: p4)
        diamond.close()
        return diamond
    }
    
    private func createSquiggle(_ rect: CGRect) -> UIBezierPath{
        let squiggle:UIBezierPath = UIBezierPath()
        print ("\(rect)")
        
        squiggle.move(to: getCenter(rect))
        squiggle.lineJoinStyle = .round
        squiggle.lineCapStyle = .round
        squiggle.move(to: rect.origin)
        squiggle.addQuadCurve(to: CGPoint(x: rect.midX * 0.5, y: rect.maxY * 0.25), controlPoint: CGPoint(x: rect.maxX * 0.4, y: rect.maxY * 0.01))
        squiggle.addCurve(to: CGPoint(x: rect.midX * 0.5, y: rect.maxY * 0.85), controlPoint1: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 0.4), controlPoint2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY * 0.5))
        squiggle.addQuadCurve(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.85), controlPoint: CGPoint(x: rect.maxX * 0.6, y: rect.maxY * 0.99))
        squiggle.addCurve(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.25), controlPoint1: CGPoint(x: rect.maxX * 0.9, y: rect.maxY * 0.5), controlPoint2: CGPoint(x: rect.maxX * 0.65, y: rect.maxY * 0.7))
        return squiggle
    }
    
    private func createCircle(_ rect: CGRect) -> UIBezierPath{
        let circle = UIBezierPath()
        let center = getCenter(rect)
        let radius = min(rect.width, rect.height)/2 * 0.9
        circle.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: 2*CGFloat.pi, clockwise: false)
        return circle
    }
    
    private func getDimensionsForCell (_ rect: CGRect) -> (rowCount:Int, columnCount:Int){
        if rect.height/rect.width > 1.0{
            return(number, 1)
        } else {
        return(1, number)
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.green.setFill()
        UIColor.blue.setStroke()
        let cages = Grid.init(layout:.dimensions(rowCount: getDimensionsForCell(rect).rowCount, columnCount: getDimensionsForCell(rect).columnCount) , frame: rect)
        for idx in 0..<cages.cellCount{
            let shape = createDiamond(cages[idx]!)
            shape.stroke()
            shape.fill()
        }
        
    }

}

extension DrawView{
    private struct SetViewRatios {
        static let frameInsetRatio: CGFloat = 0.1
        static let maxSymbolsPerCard = 3
    }
    
    private func cardInset (_ rect: CGRect) -> CGFloat{
        return (rect.width + rect.height)/2 * SetViewRatios.frameInsetRatio
    }
    private func symbolBounds (_ bounds: CGRect) -> CGRect{
        let symbolFrame = bounds.inset(by: UIEdgeInsets.init(top: cardInset(bounds), left: cardInset(bounds), bottom: cardInset(bounds), right: cardInset(bounds)))
        return symbolFrame
    }
    private func getCenter (_ rect:CGRect) -> CGPoint{
        return CGPoint(x: rect.midX, y: rect.midY)
    }
}
