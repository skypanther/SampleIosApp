//
//  ParametersContainer.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 5/8/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class ParametersContainer: UIView {
    
    let heading: UILabel = {
        let head = UILabel()
        head.text = "Filter Parameters"
        head.textColor = .white
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.headline)
        head.font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize)
        head.translatesAutoresizingMaskIntoConstraints = false
        return head
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(heading)
        heading.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func addChildView(_ view: UIView) {
        let kids = self.subviews
        let lastChild = kids[kids.count - 1]
        self.addSubview(view)
        view.topAnchor.constraint(equalTo: lastChild.bottomAnchor, constant: 20).isActive = true
    }
    
}
