//
//  ParametersContainer.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 5/8/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class ParametersContainer: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.distribution = .fillProportionally
        self.alignment = .top
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func addChildView(_ view: UIView) {
        self.addArrangedSubview(view)
    }

}
