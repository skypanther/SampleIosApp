//
//  Photo.swift
//  FotoFilter
//
//  Created by Timothy Poulsen on 4/25/19.
//  Copyright © 2019 Tim Poulsen. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc dynamic var photoDescription = ""
    @objc dynamic var photoPath = ""
    @objc dynamic var created = Date()
}

class PhotoManager {
    
    let realm = try! Realm()
    
    public func all() -> Results<Photo> {
        return self.realm.objects(Photo.self)
    }
    
    public func count() -> Int {
        let photos = self.realm.objects(Photo.self)
        return photos.count
    }
    
    public func add(_ photo: Photo) {
        try! self.realm.write {
            self.realm.add(photo)
        }
    }
    
}
