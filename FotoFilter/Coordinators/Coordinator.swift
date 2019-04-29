//
//  Coordinator.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/29/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set}
    func start()
}
