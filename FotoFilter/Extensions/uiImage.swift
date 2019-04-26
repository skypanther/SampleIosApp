//
//  uiImage.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /**
     Crops an image to the CGRect
     - Parameters:
     - toRect: CGRect
     - Returns: UIImage
     - Usage:
     var myImage = UIImage(named: "foo")
     someImageView.image = myImage.crop(CGRect(x: 0, y: 0, width: 100, height: 100))
     */
    func crop(_ rect: CGRect) -> UIImage {
        if let imageRef = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: imageRef)
        }
        return self
    }
    
    /**
     Resize image proportionally to a given width
     - Parameters:
     - newWidth: CGFloat
     - Returns: UIImage
     - Usage:
     var myImage = UIImage(named: "foo")
     someImageView.image = myImage.scaleUIImageToWidth(150)
     */
    func scaleUIImageToWidth(_ newWidth: CGFloat) -> UIImage {
        let scale = newWidth / size.width
        let newHeight = size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    /**
     Rotate an image by the specified radians
     - Parameters:
     - radians: CGFloat, number of radians to rotate the image
     - Returns: UIImage
     */
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        return self
    }
    
    /**
     Mirrors an image horizontally (left-right); repaints pixels rather than simply
     setting a new EXIF orientation.
     - Returns: UIImage
     */
    func mirrorHorizontally() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let ciImage = CIImage(cgImage: cgImage).transformed(by: CGAffineTransform(scaleX: -1, y: 1))
        let ciContext = CIContext()
        if let mirroredCGImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: mirroredCGImage)
        } else {
            return self
        }
    }
    
    /**
     Mirrors an image vertically (up-down); repaints pixels rather than simply
     setting a new EXIF orientation.
     - Returns: UIImage
     */
    func mirrorVertically() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let ciImage = CIImage(cgImage: cgImage).transformed(by: CGAffineTransform(scaleX: 1, y: -1))
        let ciContext = CIContext()
        if let mirroredCGImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: mirroredCGImage)
        } else {
            return self
        }
    }

}
