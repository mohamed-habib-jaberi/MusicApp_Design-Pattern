//
//  LibraryAPI.swift
//  MusicApp_Design Pattern
//
//  Created by mohamed  habib on 11/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import Foundation
import UIKit


final class LibraryAPI {
    // 1
    static let shared = LibraryAPI()
    // 2
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false
    // 3
    private init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(with:)), name: .BLDownloadImage, object: nil)

    }
    
    func getAlbums() -> [Album] {
      return persistencyManager.getAlbums()
    }
      
    func addAlbum(_ album: Album, at index: Int) {
      persistencyManager.addAlbum(album, at: index)
      if isOnline {
        httpClient.postRequest("/api/addAlbum", body: album.description)
      }
    }
      
    func deleteAlbum(at index: Int) {
      persistencyManager.deleteAlbum(at: index)
      if isOnline {
        httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
      }
    }
    
    @objc func downloadImage(with notification: Notification) {
      guard let userInfo = notification.userInfo,
        let imageView = userInfo["imageView"] as? UIImageView,
        let coverUrl = userInfo["coverUrl"] as? String,
        let filename = URL(string: coverUrl)?.lastPathComponent else {
          return
      }
      
      if let savedImage = persistencyManager.getImage(with: filename) {
        imageView.image = savedImage
        return
      }
      
      DispatchQueue.global().async {
        let downloadedImage = self.httpClient.downloadImage(coverUrl) ?? UIImage()
        DispatchQueue.main.async {
          imageView.image = downloadedImage
          self.persistencyManager.saveImage(downloadedImage, filename: filename)
        }
      }
    }


}
