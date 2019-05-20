//
//  ParameterView.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 5/8/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

class ParameterView: UIStackView {

    var title: UILabel = {
        var t = UILabel()
        t.textColor = UIColor.white
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.caption1)
        t.font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        return t
    }()
    
    var slider: UISlider = {
        var s = UISlider()
        s.isContinuous = true
        s.translatesAutoresizingMaskIntoConstraints = false
        s.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    public func setTitle(_ text: String) {
        self.title.text = text
    }

    public func setSliderLimits(min: NSNumber=0.0, max: NSNumber=1.0, value: NSNumber=0.0) {
        self.slider.minimumValue = min as! Float
        self.slider.maximumValue = max as! Float
        self.slider.value = value as! Float
    }
    
    public func setSliderCallback(cb: @escaping (_ value: NSNumber) -> Void) {
//        self.slider.addTarget(self, action: cb, for: .valueChanged)
    }

    private func setupUI() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 16.0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .blue
        self.addArrangedSubview(title)
        self.addArrangedSubview(slider)
    }
}
