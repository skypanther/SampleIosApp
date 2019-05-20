//
//  PhotoModelTests
//  FotoFilterTests
//
//  Created by Timothy Poulsen on 3/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import XCTest
import RealmSwift
@testable import FotoFilter

class PhotoModelTests: XCTestCase {

    let photoManager = PhotoManager()
    var photos: Results<Photo>?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCountOfPhotos() {
        let count = photoManager.count()
        let all = photoManager.all()
        XCTAssertEqual(count, all.count, "Wrong number of photos returned")
    }

    func testGetAddPhoto() {
        let count = photoManager.count()
        photoManager.addDummyPhoto()
        let newcount = photoManager.count()
        XCTAssertEqual(count + 1, newcount, "Test photo not added")
    }
    
}
