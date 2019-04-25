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
            if let photo = photo, photo.photoPath != "" {
                // show it
                image.image = UIImage(contentsOfFile: photo.photoPath)
//                print(photo.photoDescription)
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
