//
//  GeneralUtilities.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import Foundation
import UIKit

class GeneralUtilities {
    /**
     Get the timestamp in milliseconds
     - Parameters: none
     - Returns: Int
     */
    static func getTimeMilliseconds() -> Int {
        return Int(NSDate().timeIntervalSince1970 * 1000)
    }
    
    /**
     Run a function after a specified number of seconds
     - Parameters:
     - seconds: Double - Number of seconds to wait
     - function: func - Function to run
     */
    static func delayFunctionBy(seconds: Double, function: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            function()
        }
    }
    
    /**
     Converts dictionary to JSON
     - Parameters:
     - _ dictionary: [String:Any]
     - Returns: Data?
     */
    static func getJsonFromDictionary(_ dictionary: [String:Any]) -> Data? {
        do {
            let json = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            return json
        } catch {
            return nil
        }
    }
    /**
     Force the keyboard to hide
     - Parameters: none
     - Returns: Void
     */
    static func hideKeyboard() -> Void {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /**
     Convert time interval in seconds to a string of mins & secs in specified format
     - Parameters:
     - interval: Double
     - format: NSString - format specifier, defaults to "mm:ss" format
     - Returns: String
     */
    static func stringTimeFromTimeInterval(_ interval: Double, format: NSString = "%0.2d:%0.2d") -> String {
        assert(interval <= 3600)
        let hours = (Int(interval) / 3600)
        let minutes = Int(interval / 60) - Int(hours * 60)
        let seconds = Int(interval) - (Int(interval / 60) * 60)
        return NSString(format: format, minutes, seconds) as String
    }
    
    /**
     Convert timeIntervalSince1970 to string in 'mm/yy/dd' format
     - Parameters:
     - timestamp: Double
     - Returns: String
     */
    static func stringDateFromTimeIntervalSince1970(_ timestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "M/dd/yy h:mm a"
        let timestampDate = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: timestampDate)
    }
    
    /**
     Show a one-button alert dialog
     - Parameters:
     - containerView: UIViewController
     - title: String
     - message: String
     - buttonText: String, defaults to "OK"
     - Returns: Void
     */
    static func showAlert(containerView: UIViewController, title: String, message: String, buttonText: String = "OK") -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        DispatchQueue.main.async {
            containerView.present(alert, animated: true)
        }
    }

    /**
     Get a `URL` object pointing to a a file of a given name, assuming the file is in the Documents directory
     - Parameters:
     - filename: String, file name
     - Returns: URL
     */
    static func getFullURLToMedia(filename: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: documentsURL.path).appendingPathComponent(filename)
    }

    /**
     Delete a file from the Documents directory
     - Parameters:
     - named: String
     - Returns: Bool
     */
    static func deleteFile(named: String) -> Bool {
        let fileToDelete = getFullURLToMedia(filename: named)
        do {
            try FileManager.default.removeItem(atPath: fileToDelete.standardizedFileURL.path)
            return true
        } catch let error as NSError {
            print(error)  // typically this would be hooked up to NewRelic or similar logging service
            return false
        }
    }
    
    static func makeArrow(parentView: UIView) -> CAShapeLayer {
        let width = parentView.frame.width
        let height = parentView.frame.height
        let startPoint = CGPoint(x: width/2, y: height/4)
        let endPoint = CGPoint(x: width - 46, y: 96)
        let arrowPath = UIBezierPath.bezierPathWithArrowFromPoint(startPoint: startPoint,
                                                                  endPoint: endPoint,
                                                                  tailWidth: 8,
                                                                  headWidth: 20,
                                                                  headLength: 14)
        let shape = CAShapeLayer()
        shape.path = arrowPath.cgPath
        shape.fillColor = UIColor.darkGray.cgColor;
        return shape
    }
    

}
