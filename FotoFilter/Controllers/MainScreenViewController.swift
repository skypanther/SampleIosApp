//
//  ViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: PortraitViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let photoManager = PhotoManager()
    var photos: Results<Photo>?
    var arrow: CAShapeLayer? = nil
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noPhotosLabel: UILabel!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        // TODO: Take a photo
        self.photoManager.addDummyPhoto()
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.photos = self.photoManager.all()
    }
    
    private func setupUI() {
        cameraButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .normal)
        cameraButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .highlighted)
        cameraButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .focused)
        cameraButtonOutlet.title = ButtonStrings.camera
        if self.photoManager.count() == 0 {
            self.collectionView.isHidden = true
            self.noPhotosLabel.isHidden = false
            if self.arrow == nil {
                self.arrow = GeneralUtilities.makeArrow(parentView: bgView)
            }
            self.bgView.layer.addSublayer(self.arrow!)
        } else {
            self.collectionView.isHidden = false
            self.noPhotosLabel.isHidden = true
            if self.arrow != nil {
                self.arrow!.removeFromSuperlayer()
            }
        }
    }

}

// MARK: CollectionView handlers
extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            coordinator?.editPhoto(photo: pictures[indexPath.item])
        }
    }
    

}
