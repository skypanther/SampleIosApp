//
//  GeneralUtilitiesTests.swift
//  FotoFilterTests
//
//  Created by Timothy Poulsen on 5/20/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import XCTest
@testable import FotoFilter

class GeneralUtilitiesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTime() {
        let now = GeneralUtilities.getTimeMilliseconds()
        // seems odd, but https://stackoverflow.com/a/25727395/292947
        XCTAssert(now as Any is Int, "getTimeMilliseconds should return an Int not \(String(describing: type(of: now)))")
    }
    
    func testGetFullURLToMedia() {
        let url = GeneralUtilities.getFullURLToMedia(filename: "test.jpg")
        XCTAssert(url as Any is URL, "getFullURLToMedia should return URL not \(String(describing: type(of: url)))")
        XCTAssertEqual(url.lastPathComponent, "test.jpg", "getFullURLToMedia returned an URL without the file name")
        XCTAssertTrue(url.standardizedFileURL.path.contains("Documents"), "getFullURLToMedia returned an URL to outside the Documents folder")
    }
    
    func testMakeArrow() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let arrow = GeneralUtilities.makeArrow(parentView: view)
        if let path = arrow.path {
            XCTAssertFalse(path.isEmpty, "makeArrow returned an empty path")
        } else {
            XCTAssertFalse(true, "makeArrow did not return a valid path")
        }
    }
}
