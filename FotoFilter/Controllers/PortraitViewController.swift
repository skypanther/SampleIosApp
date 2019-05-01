//
//  PortraitViewController.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/30/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class PortraitViewController: UIViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.OrientationTools.lockOrientation(.portrait, andRotateTo: .portrait)
    }

}
