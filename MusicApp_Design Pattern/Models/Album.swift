//
//  Album.swift
//  MusicApp_Design Pattern
//
//  Created by mohamed  habib on 11/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import Foundation


struct Album {
  let title : String
  let artist : String
  let genre : String
  let coverUrl : String
  let year : String
}

extension Album: CustomStringConvertible {
    
    var description: String {
        
        return "title: \(title)" +
          " artist: \(artist)" +
          " genre: \(genre)" +
          " coverUrl: \(coverUrl)" +
        " year: \(year)"
    }
    
}

typealias AlbumData = (title: String, value: String)

extension Album {
  var tableRepresentation: [AlbumData] {
    return [
      ("Artist", artist),
      ("Album", title),
      ("Genre", genre),
      ("Year", year)
    ]
  }
}
