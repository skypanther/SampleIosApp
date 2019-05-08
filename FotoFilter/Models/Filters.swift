//
//  Filters.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/29/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

// TODO: Refactor this! Just a quick & dirty implementation so I can work on the UI

import Foundation
import CoreImage

enum FilterDataTypes {
    case number, color, vector, angle
}

struct FilterParam {
    let name: String
    let friendlyName: String
    var value: Any
    var min: NSNumber?
    var max: NSNumber?
    var filterDataType: FilterDataTypes
}

struct Filter {
    let name: String
    let friendlyName: String
    let params: Array<FilterParam>
}

class Filters {
    static let sharedInstance = Filters()
    
    public var filters: [Filter] = []
    
    private init() {
        filters.append(Filter(name: "CIColorMonochrome",
                              friendlyName: "Grayscale",
                              params: [
                                FilterParam(name: "inputIntensity", friendlyName: "Intensity", value: 1.0, min: 0.0, max: 255.0, filterDataType: .number),
                                FilterParam(name: "inputColor", friendlyName: "Value", value: CIColor.gray, min: 0.0, max: 359.0, filterDataType: .color)
            ]))
        filters.append(Filter(name: "CISepiaTone",
                              friendlyName: "Sepia",
                              params: [
                                FilterParam(name: "inputIntensity", friendlyName: "Intensity", value: 0.75, min: 0.0, max: 1.0, filterDataType: .number)
            ]))
        filters.append(Filter(name: "CIColorInvert",
                              friendlyName: "Invert",
                              params: []))
        filters.append(Filter(name: "CIColorPosterize",
                              friendlyName: "Posterize",
                              params: [
                                FilterParam(name: "inputLevels", friendlyName: "Amount", value: 10.0, min: 1.0, max: 32.0, filterDataType: .number)
            ]))
        filters.append(Filter(name: "CICircularWrap",
                              friendlyName: "Spiral",
                              params: [
                                FilterParam(name: "inputAngle", friendlyName: "Angle", value: 15.0, min: 0.0, max: 359.0, filterDataType: .angle),
                                FilterParam(name: "inputCenter", friendlyName: "Center point", value: CIVector(x: 0.5, y: 0.5), min: 0.0, max: 1.0, filterDataType: .vector),
                                FilterParam(name: "inputRadius", friendlyName: "Radius", value: 40, min: 0.0, max: 100.0, filterDataType: .number)
            ]))

    }

}
