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
  private init() {

  }
}
