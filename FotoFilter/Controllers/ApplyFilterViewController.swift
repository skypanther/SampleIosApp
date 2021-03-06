//
//  ApplyFilterViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/26/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit
import RealmSwift
import CoreImage

class ApplyFilterViewController: PortraitViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    var photo: Photo?
    var miniPhoto: UIImage?
    var filters: [Filter]?
    var currentFilter: Filter?
    var spinner: LoadingSpinner?
    
    // Outlets
    @IBOutlet weak var screenBackgroundView: UIView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        homeButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .normal)
        homeButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .highlighted)
        homeButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .focused)
        homeButtonOutlet.title = ButtonStrings.home
        shareButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .normal)
        shareButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .highlighted)
        shareButtonOutlet.setTitleTextAttributes(Config.sharedInstance.navBarTitleTextAttributes, for: .focused)
        shareButtonOutlet.title = ButtonStrings.share
        self.filters = Filters.sharedInstance.filters
        self.currentFilter = self.filters?[0]
        self.spinner = LoadingSpinner(frame: self.screenBackgroundView.frame)
        if let pic = photo {
            let fullPath = GeneralUtilities.getFullURLToMedia(filename: pic.photoFileName)
            if var img = UIImage(contentsOfFile: fullPath.standardizedFileURL.path) {
                self.miniPhoto = img.scaleUIImageToWidth(80).crop(CGRect(x: 0, y: 0, width: 80, height: 80))
                img = img.scaleUIImageToWidth(375)
                img = img.crop(CGRect(x: 0, y: 0, width: 375, height: 375))
                self.largeImage.image = img
            } else {
                print("can't find photo at: ", pic.photoFileName)
            }
            filterCollectionView.reloadData()
        }

    }
    
    fileprivate func applyFilter(_ filter: Filter) {
        if let pic = photo {
            let fullPath = GeneralUtilities.getFullURLToMedia(filename: pic.photoFileName)
            if let img = UIImage(contentsOfFile: fullPath.standardizedFileURL.path) {
                addFilterParamsView(forFilter: filter)
                processImage(img, filter: filter)
            }
        }
    }

    fileprivate func addFilterParamsView(forFilter filter: Filter) {
        for childView in filterDetails.subviews {
            childView.removeFromSuperview()
        }
        let paramContainer = ParametersContainer()
        filterDetails.addSubview(paramContainer)
        paramContainer.widthAnchor.constraint(equalTo: filterDetails.widthAnchor, multiplier: 1.0).isActive = true
        paramContainer.heightAnchor.constraint(equalTo: filterDetails.heightAnchor, multiplier: 1.0).isActive = true
        for param in filter.params {
            let paramView = ParameterView()
            paramView.setTitle(param.friendlyName)
            if param.filterDataType != .vector && param.filterDataType != .color {
                paramView.setSliderLimits(min: param.min ?? 0, max: param.max ?? 0, value: param.value as! NSNumber)
                paramView.slider.addTarget(self, action: "processImage", for: .valueChanged)
                paramContainer.addChildView(paramView)
            }
        }
        if filter.params.count == 0 {
            paramContainer.addChildView(makeNoParamsLabel())
        }
    }

    fileprivate func processImage(_ img: UIImage, filter: Filter) {
        let context = CIContext(options: nil)
        if let activeFilter = CIFilter(name: filter.name) {
            let beginImage = CIImage(image: img)
            activeFilter.setValue(beginImage, forKey: "inputImage")
            for param in filter.params {
                activeFilter.setValue(param.value, forKey: param.name)
            }
            if let output = activeFilter.outputImage {
                if let cgimage = context.createCGImage(output, from: output.extent) {
                    let outputImage = UIImage(cgImage: cgimage)
                    self.largeImage.image = outputImage.scaleUIImageToWidth(375).crop(CGRect(x: 0, y: 0, width: 375, height: 375))
                }
            }
        }
    }

    fileprivate func makeNoParamsLabel() -> UILabel {
        let lbl = UILabel()
        lbl.text = "No configurable parameters for this filter"
        lbl.textColor = .white
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.caption1)
        lbl.font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
}

// MARK: CollectionView handlers

extension ApplyFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath as IndexPath) as! FilterCellCollectionViewCell
        cell.image = self.miniPhoto
        cell.filter = self.filters?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        screenBackgroundView.addSubview(spinner!)
        if let fltr = self.filters?[indexPath.item] {
            applyFilter(fltr)
        }
        GeneralUtilities.delayFunctionBy(seconds: 0.15, function: {
            self.spinner!.removeFromSuperview()
        })
    }
    

}
