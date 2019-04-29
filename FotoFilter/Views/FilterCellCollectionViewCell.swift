//
//  FilterCellCollectionViewCell.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/26/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import CoreImage

class FilterCellCollectionViewCell: UICollectionViewCell {
    var image: UIImage?
    
    @IBOutlet weak var thumbUIImageView: UIImageView!

    var filter: Filter? {
        didSet {
            print("didSet")
            let context = CIContext(options: nil)
            if let fltr = filter, let currentFilter = CIFilter(name: fltr.name), let img = image {
                let beginImage = CIImage(image: img)
                print("got a CIImage")
                currentFilter.setValue(beginImage, forKey: "inputImage")
                for param in fltr.params {
                    print("applying param: \(param.name)")
                    currentFilter.setValue(param.value, forKey: param.name)
                }
                if let output = currentFilter.outputImage {
                    print("got output")
                    if let cgimage = context.createCGImage(output, from: output.extent) {
                        print("setting output image")
                        thumbUIImageView.image = UIImage(cgImage: cgimage)
                    }
                }
            }
        }
    }
    
    
    
}
