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
    @objc dynamic var photoFileName = ""
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
    
    public func addDummyPhoto() {
        let photos = self.realm.objects(Photo.self)
        let mockPhoto = Photo()
        mockPhoto.photoDescription = "Mock photo"
        mockPhoto.photoFileName = "bean\(photos.count + 1).jpg"
        try! self.realm.write {
            self.realm.add(mockPhoto)
            self.copySamplePhotoToDocuments(targetFileName: mockPhoto.photoFileName)
        }
    }

    private func copySamplePhotoToDocuments(targetFileName: String) {
        if let samplePhotoURL = Bundle.main.url(forResource: "bean", withExtension: "jpg") {
            // even though the sample JPG is in the SamplePhotos folder, the above will find
            // it (and adding the `subdirectory=""` param will cause it to fail!)
            let targetURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(targetFileName)
            do {
                try FileManager.default.copyItem(at: samplePhotoURL, to: targetURL)
            }
            catch {
                print("failed to copy example")
                print(error)
            }
        }
    }

}
