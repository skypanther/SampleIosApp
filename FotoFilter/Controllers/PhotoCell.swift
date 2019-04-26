//
//  PhotoCell.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    var photo: Photo? {
        didSet {
            if let photo = photo, photo.photoFileName != "" {
                // show it
                let fullPath = GeneralUtilities.getFullURLToMedia(filename: photo.photoFileName)
                if var img = UIImage(contentsOfFile: fullPath.standardizedFileURL.path) {
                    img = img.scaleUIImageToWidth(180)
                    img = img.crop(CGRect(x: 0, y: 0, width: 180, height: 180))
                    image.image = img
                } else {
                    print("can't find photo at: ", photo.photoFileName)
                }
            } else {
                let lbl: UILabel = {
                    let label = UILabel()
                    label.textColor = .white
                    label.text = "No Photo"
                    return label
                }()
                self.addSubview(lbl)
                lbl.pinEdgesToSuperView()

            }
        }
    }
}
