//
//  ViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosLabel: UILabel!
    
    let photoManager = PhotoManager()
    var photos: Results<Photo>?

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if true || self.photoManager.count() == 0 {
//            let mockPhoto = Photo()
//            mockPhoto.photoDescription = "mock photo"
//            self.photoManager.add(mockPhoto)
            self.collectionView.isHidden = true
            self.noPhotosLabel.isHidden = false
            let width = self.bgView.frame.width
            let height = self.bgView.frame.height
            let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: CGPoint(x: width/2, y: height/4), endPoint: CGPoint(x: width - 46, y: 96), tailWidth: 4, headWidth: 16, headLength: 12)
            let shape = CAShapeLayer()
            shape.path = arrowPath.cgPath
            shape.fillColor = UIColor.darkGray.cgColor;
            self.bgView.layer.addSublayer(shape)
            
        } else {
            self.collectionView.isHidden = false
            self.noPhotosLabel.isHidden = true
        }
        self.photos = self.photoManager.all()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath as IndexPath) as! PhotoCell
        if let pictures = self.photos {
            cell.photo = pictures[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }

}
