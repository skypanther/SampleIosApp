//
//  MainCoordinator.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/29/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainScreenViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func editPhoto(photo: Photo) {
        let vc = ApplyFilterViewController.instantiate()
        vc.photo = photo
        navigationController.pushViewController(vc, animated: true)
    }

}
