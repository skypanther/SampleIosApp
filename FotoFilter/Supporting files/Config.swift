//
//  Config.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/26/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import UIKit

enum ButtonStrings {
    static let alertCircle = "\u{e90e}"
    static let camera = "\u{e90f}"
    static let check = "\u{e910}"
    static let chevronLeft = "\u{e911}"
    static let chevronRight = "\u{e912}"
    static let filter = "\u{e913}"
    static let help = "\u{e914}"
    static let home = "\u{e915}"
    static let image = "\u{e916}"
    static let minus = "\u{e917}"
    static let reset = "\u{e918}"
    static let share = "\u{e919}"
    static let trash = "\u{e}"
}

class Config {
    static let sharedInstance = Config()
    
    /* This prevents others from using the default '()' initializer with this class */
    private init() {}

    
    let navBarTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "orange") ?? .orange,
                                     NSAttributedString.Key.font: UIFont(name: "icomoon", size: 21)!]


    private var configDictionary = [
        "appDeveloper": "Tim Poulsen",
        "appName": "FotoFilter",
        "appDescription": "Take a photo, apply a filter"
    ]
    
    /**
     Returns item from configuration dictionary
     - Parameters:
     - _ key: String
     - Returns: String?
     */
    public func get(_ key: String) -> String? {
        if let dictionaryValue = self.configDictionary[key] {
            return dictionaryValue
        }
        return nil
    }
    
}
