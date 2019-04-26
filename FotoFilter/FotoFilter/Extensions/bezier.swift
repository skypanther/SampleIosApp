//
//  bezier.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/25/19.
//  Source: https://gist.github.com/mwermuth/07825df27ea28f5fc89a
//  Updated to Swift 4 by Tim Poulsen
//

import Foundation
import UIKit

extension UIBezierPath {
    
    class func getAxisAlignedArrowPoints(_ points: inout Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat ) {
        
        let tailLength = forLength - headLength
        // Removing this first point as defined in the source script
        // creates a line that starts with zero width and
        // gradually increases to the final tailWidth value
        // points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: headWidth/2))
        points.append(CGPoint(x: forLength, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth/2))
        points.append(CGPoint(x: tailLength, y: -tailWidth/2))
        points.append(CGPoint(x: 0, y: -tailWidth/2))
        
    }
    
    
    class func transformForStartPoint(startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform{
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: startPoint.x, ty: startPoint.y)
    }
    
    
    class func bezierPathWithArrowFromPoint(startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
        
        let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
        let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
        let length = hypotf(xdiff, ydiff)
        
        var points = [CGPoint]()
        self.getAxisAlignedArrowPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        let transform: CGAffineTransform = self.transformForStartPoint(startPoint: startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        let cgPath: CGMutablePath = CGMutablePath()
        cgPath.addLines(between: points, transform: transform)
        cgPath.closeSubpath()
        
        let uiPath: UIBezierPath = UIBezierPath(cgPath: cgPath)
        return uiPath
    }
}
