//
//  ViewController.swift
//  MusicApp_Design Pattern
//
//  Created by mohamed  habib on 11/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private enum Constants {
      static let CellIdentifier = "Cell"
    }
    
     @IBOutlet var tableView: UITableView!
     @IBOutlet var undoBarButtonItem: UIBarButtonItem!
     @IBOutlet var trashBarButtonItem: UIBarButtonItem!
    
    @IBOutlet var horizontalScrollerView: HorizontalScrollerView!
    
    private var currentAlbumIndex = 0
    private var currentAlbumData: [AlbumData]?
    private var allAlbums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //1
        allAlbums = LibraryAPI.shared.getAlbums()

        //2
        tableView.dataSource = self
        
        horizontalScrollerView.dataSource = self
        horizontalScrollerView.delegate = self
        horizontalScrollerView.reload()

        
        showDataForAlbum(at: currentAlbumIndex)

        
    }

    private func showDataForAlbum(at index: Int) {
        
      // defensive code: make sure the requested index is lower than the amount of albums
      if (index < allAlbums.count && index > -1) {
        // fetch the album
        let album = allAlbums[index]
        // save the albums data to present it later in the tableview
        currentAlbumData = album.tableRepresentation
      } else {
        currentAlbumData = nil
      }
      // we have the data we need, let's refresh our tableview
      tableView.reloadData()
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let albumData = currentAlbumData else {
          return 0
        }
        return albumData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
        if let albumData = currentAlbumData {
          let row = indexPath.row
          cell.textLabel!.text = albumData[row].title
          cell.detailTextLabel!.text = albumData[row].value
        }
        return cell
        
    }
    

}

// MARK: - HorizontalScrollerViewDelegate
extension ViewController: HorizontalScrollerViewDelegate {
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
    //1
    let previousAlbumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
    previousAlbumView.highlightAlbum(false)
    //2
    currentAlbumIndex = index
    //3
    let albumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
    albumView.highlightAlbum(true)
    //4
    showDataForAlbum(at: index)
  }
}

// MARK: - HorizontalScrollerViewDataSource
extension ViewController: HorizontalScrollerViewDataSource {
  func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
    return allAlbums.count
  }
  
  func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
    let album = allAlbums[index]
    let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
    if currentAlbumIndex == index {
      albumView.highlightAlbum(true)
    } else {
      albumView.highlightAlbum(false)
    }
    return albumView
  }
}
