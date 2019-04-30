//
//  LoadingSpinner.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/29/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class LoadingSpinner: UIView {

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.setColor(.black)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()

    let spinnerBox: UIView = {
        let sbView = UIView()
        sbView.clipsToBounds = true
        sbView.layer.cornerRadius = 10
        sbView.backgroundColor = UIColor(named: "translucentLightGrey")
        sbView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        return sbView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        spinnerBox.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: spinnerBox.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: spinnerBox.centerYAnchor).isActive = true

        spinnerBox.center = self.center
        self.addSubview(spinnerBox)
        self.backgroundColor = UIColor(named: "translucentDarkGrey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
