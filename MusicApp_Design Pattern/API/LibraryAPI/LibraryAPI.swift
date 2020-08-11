//
//  LibraryAPI.swift
//  MusicApp_Design Pattern
//
//  Created by mohamed  habib on 11/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import Foundation

final class LibraryAPI {
    // 1
    static let shared = LibraryAPI()
    // 2
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false
    // 3
    private init() {
        
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

}
