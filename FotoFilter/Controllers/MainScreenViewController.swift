//
//  ViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosLabel: UILabel!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        // TODO: Take a photo
        self.photoManager.addDummyPhoto()
        self.collectionView.reloadData()
    }
    
    let photoManager = PhotoManager()
    var photos: Results<Photo>?
    var arrow: CAShapeLayer? = nil

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.OrientationTools.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: [])
        cameraButtonOutlet.title = ButtonStrings.camera
        if self.photoManager.count() == 0 {
            self.collectionView.isHidden = true
            self.noPhotosLabel.isHidden = false
            if self.arrow == nil {
                self.arrow = makeArrow()
            }
            self.bgView.layer.addSublayer(self.arrow!)
        } else {
            self.collectionView.isHidden = false
            self.noPhotosLabel.isHidden = true
            if self.arrow != nil {
                self.arrow!.removeFromSuperlayer()
            }
        }
        self.photos = self.photoManager.all()
    }

    // MARK: CollectionView handlers
    
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
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 3
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pictures = self.photos {
            if let applyFilterView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "applyFilterScreen") as? ApplyFilterViewController {
                applyFilterView.photo = pictures[indexPath.item]
                if let navigator = navigationController {
                    navigator.pushViewController(applyFilterView, animated: true)
                }
            }
        }
    }
    
    private func makeArrow() -> CAShapeLayer {
        let width = self.bgView.frame.width
        let height = self.bgView.frame.height
        let startPoint = CGPoint(x: width/2, y: height/4)
        let endPoint = CGPoint(x: width - 46, y: 96)
        let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: startPoint,
                                                                  endPoint: endPoint,
                                                                  tailWidth: 8,
                                                                  headWidth: 20,
                                                                  headLength: 14)
        let shape = CAShapeLayer()
        shape.path = arrowPath.cgPath
        shape.fillColor = UIColor.darkGray.cgColor;
        return shape
    }

}
