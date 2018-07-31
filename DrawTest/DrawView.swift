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
    @IBInspectable
    var shape:Int = 2 { didSet {setNeedsLayout(); setNeedsDisplay()}}
    @IBInspectable
    var p1_dx:CGFloat = 0
    @IBInspectable
    var p1_dy:CGFloat = 0
    @IBInspectable
    var p2_dx:CGFloat = 0
    @IBInspectable
    var p2_dy:CGFloat = 0
    @IBInspectable
    var p3_dx:CGFloat = 0
    @IBInspectable
    var p3_dy:CGFloat = 0
    @IBInspectable
    var p4_dx:CGFloat = 0
    @IBInspectable
    var p4_dy:CGFloat = 0
    @IBInspectable
    var p5_dx:CGFloat = 0
    @IBInspectable
    var p5_dy:CGFloat = 0
    @IBInspectable
    var p6_dx:CGFloat = 0
    @IBInspectable
    var p6_dy:CGFloat = 0
    @IBInspectable
    var c1_dx:CGFloat = 0
    @IBInspectable
    var c1_dy:CGFloat = 0
    @IBInspectable
    var c2_dx:CGFloat = 0
    @IBInspectable
    var c2_dy:CGFloat = 0
    @IBInspectable
    var c3_dx:CGFloat = 0
    @IBInspectable
    var c3_dy:CGFloat = 0
    @IBInspectable
    var c4_dx:CGFloat = 0
    @IBInspectable
    var c4_dy:CGFloat = 0
    @IBInspectable
    var c5_dx:CGFloat = 0
    @IBInspectable
    var c5_dy:CGFloat = 0
    @IBInspectable
    var c6_dx:CGFloat = 0
    @IBInspectable
    var c6_dy:CGFloat = 0
    @IBInspectable
    var c7_dx:CGFloat = 0
    @IBInspectable
    var c7_dy:CGFloat = 0
    @IBInspectable
    var c8_dx:CGFloat = 0
    @IBInspectable
    var c8_dy:CGFloat = 0
    @IBInspectable
    var c9_dx:CGFloat = 0
    @IBInspectable
    var c9_dy:CGFloat = 0

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
    
    private func createOval(_ rect: CGRect) -> UIBezierPath{
        let oval = UIBezierPath()
//        let shortAxis = (min(rect.width, rect.height) * 0.9)
//        let longAxis = (max(rect.width, rect.height) * 0.9)
        let p1 = CGPoint(x: rect.origin.x + 0.75 * rect.size.width, y: rect.origin.y + 2*cardInset(rect))
        let p2 = CGPoint(x: p1.x, y: rect.origin.y + rect.height - 2*cardInset(rect))
        let p3 = CGPoint(x: rect.origin.x + 0.25 * rect.size.width, y: p2.y)
        let p4 = CGPoint(x: p3.x, y:p1.y)
        let cp1 = CGPoint(x: rect.origin.x + rect.size.width - cardInset(rect)/2, y: rect.origin.y + rect.height/2)
        let cp2 = CGPoint(x: rect.origin.x + rect.size.width/2, y: rect.origin.y + rect.size.height - cardInset(rect)/2)
        let cp3 = CGPoint(x: rect.origin.x + cardInset(rect)/2, y: cp1.y)
        let cp4 = CGPoint(x: cp2.x, y: rect.origin.y + cardInset(rect)/2)
        oval.move(to: p1)
        oval.addQuadCurve(to: p2, controlPoint: cp1)
        oval.addQuadCurve(to: p3, controlPoint: cp2)
        oval.addQuadCurve(to: p4, controlPoint: cp3)
        oval.addQuadCurve(to: p1, controlPoint: cp4)
        oval.lineJoinStyle = .round
        return oval
    }
    
    private func createCircle(_ rect: CGRect) -> UIBezierPath{
        let circle = UIBezierPath()
        let center = getCenter(rect)
        let radius = min(rect.width, rect.height)/2 * 0.9
        circle.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: 2*CGFloat.pi, clockwise: false)
        return circle
    }

    private func createSquiggle(_ rect: CGRect) -> UIBezierPath{
        let oval = UIBezierPath()
        let p1 = CGPoint(x: rect.origin.x + p1_dx, y: rect.origin.y + p1_dy)
        let p2 = CGPoint(x: rect.origin.x + p2_dx, y: rect.origin.y + p2_dy)
        let p3 = CGPoint(x: rect.origin.x + p3_dx, y: rect.origin.y + p3_dy)
        let p4 = CGPoint(x: rect.origin.x + p4_dx, y: rect.origin.y + p4_dy)
        let p5 = CGPoint(x: rect.origin.x + p5_dx, y: rect.origin.y + p5_dy)
        let p6 = CGPoint(x: rect.origin.x + p6_dx, y: rect.origin.y + p6_dy)
        let cp1 = CGPoint(x: rect.origin.x + c1_dx, y: rect.origin.y + c1_dy)
        let cp2 = CGPoint(x: rect.origin.x + c2_dx, y: rect.origin.y + c2_dy)
        let cp3 = CGPoint(x: rect.origin.x + c3_dx, y: rect.origin.y + c3_dy)
        let cp4 = CGPoint(x: rect.origin.x + c4_dx, y: rect.origin.y + c4_dy)
        let cp5 = CGPoint(x: rect.origin.x + c5_dx, y: rect.origin.y + c5_dy)
        let cp6 = CGPoint(x: rect.origin.x + c6_dx, y: rect.origin.y + c6_dy)
        let cp7 = CGPoint(x: rect.origin.x + c7_dx, y: rect.origin.y + c7_dy)
        let cp8 = CGPoint(x: rect.origin.x + c8_dx, y: rect.origin.y + c8_dy)
        let cp9 = CGPoint(x: rect.origin.x + c9_dx, y: rect.origin.y + c9_dy)
        oval.move(to: p1)
        oval.addQuadCurve(to: p2, controlPoint: cp1)
        oval.addQuadCurve(to: p3, controlPoint: cp2)
        oval.addCurve(to: p4, controlPoint1: cp3, controlPoint2: cp4)
        oval.addCurve(to: p5, controlPoint1: cp5, controlPoint2: cp6)
        oval.addQuadCurve(to: p6, controlPoint: cp7)
        oval.addCurve(to: p1, controlPoint1: cp8, controlPoint2: cp9)
        oval.lineJoinStyle = .round
        return oval
    }

    private func getDimensionsForCell (_ rect: CGRect) -> (rowCount:Int, columnCount:Int){
        if rect.height/rect.width > 1.0{
            return(number, 1)
        } else {
        return(1, number)
        }
    }
    
    override func draw(_ rect: CGRect) {
        print ("\(self.bounds)")
        UIColor.green.setFill()
        UIColor.blue.setStroke()
        var shapeFunction: (CGRect) -> UIBezierPath
        shapeFunction = {
            switch self.shape {
            case 0:
                return self.createCircle($0)
            case 1:
                return self.createDiamond($0)
            case 2:
                return self.createOval($0)
            default:
                return self.createSquiggle($0)
            }
        }
        let cages = Grid.init(layout:.dimensions(rowCount: getDimensionsForCell(rect).rowCount, columnCount: getDimensionsForCell(rect).columnCount) , frame: rect)
        for idx in 0..<cages.cellCount{
            let shapeToDraw = shapeFunction(cages[idx]!)
            shapeToDraw.stroke()
            shapeToDraw.fill()
        }
        
    }
    
    @objc func handleSwipe(recognizer:UISwipeGestureRecognizer){
        switch recognizer.direction {
        case .up, .down, .left, .right:
            shape += 1
            shape = shape > 3 ? 0 : shape
        default:
            shape = 0
        }
    }
    
    @objc func handlePinch(recognizer:UIPinchGestureRecognizer){
       switch recognizer.state{
       case .began:
        recognizer.scale = CGFloat(number)
       case .changed:
//            print ("pinch: \(recognizer.scale)")
            let scale = abs(Int(recognizer.scale * 2))
            number = scale > 0 ? scale : 1
//            recognizer.scale = 1
        default:
            break
        }

        
    }

}

extension DrawView{
    private struct SetViewRatios {
        static let frameInsetRatio: CGFloat = 0.08
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
