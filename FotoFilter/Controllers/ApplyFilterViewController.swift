//
//  ApplyFilterViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/26/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import RealmSwift

class ApplyFilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photo: Photo?
    
    // Outlets
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var homeButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var filterDetails: UIView!
    
    
    @IBAction func homeButtonHandler(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func shareButtonHandler(_ sender: UIBarButtonItem) {
    }
    
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
        homeButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: [])
        homeButtonOutlet.title = ButtonStrings.home
        shareButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: [])
        shareButtonOutlet.title = ButtonStrings.share
        if let pic = photo {
            let fullPath = GeneralUtilities.getFullURLToMedia(filename: pic.photoFileName)
            if var img = UIImage(contentsOfFile: fullPath.standardizedFileURL.path) {
                img = img.scaleUIImageToWidth(375)
                img = img.crop(CGRect(x: 0, y: 0, width: 375, height: 375))
                self.largeImage.image = img
            } else {
                print("can't find photo at: ", pic.photoFileName)
            }

        }
    }
    
    
    // MARK: CollectionView handlers

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath as IndexPath) as! FilterCellCollectionViewCell
        return cell
    }
    
    
}
