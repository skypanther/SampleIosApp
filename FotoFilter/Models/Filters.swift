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

struct FilterParam {
    let name: String
    let friendlyName: String
    let value: Any
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
                                FilterParam(name: "inputIntensity", friendlyName: "Intensity", value: 1.0),
                                FilterParam(name: "inputColor", friendlyName: "Value", value: CIColor.gray)
            ]))
        filters.append(Filter(name: "CISepiaTone",
                              friendlyName: "Sepia",
                              params: [
                                FilterParam(name: "inputIntensity", friendlyName: "Intensity", value: 0.75)
            ]))
    }

}
