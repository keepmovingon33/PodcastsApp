//
//  PodcastViewController.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

import UIKit

class PodcastSearchController: UITableViewController {
    
    let dummyPodcasts = [
        Podcast(name: "Swift UIKit", artistName: "Andy"),
        Podcast(name: "SwiftUI", artistName: "Daniel")
    ]
    
    let cellId = "cellId"
    
    // lets implement a UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        // Make searchController always appears on VC
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        // to get notify whenever we type something in the searchBar, we need to assign delegate
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        // 1. register a cell for our tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    // MARK:- UITableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyPodcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "\(dummyPodcasts[indexPath.row].name) \n \(dummyPodcasts[indexPath.row].artistName)"
        cell.imageView?.image = #imageLiteral(resourceName: "icPodcast")
        cell.textLabel?.numberOfLines = -1
        return cell
    }
}

// MARK:- UISearchBarDelegate Methods

// After we assign delegate for searchBar, We need to conform UISearchBarDelegate and write implementation for some func so that we could get notified after we type something in SearchBar
extension PodcastSearchController: UISearchBarDelegate {
    
    // This func will notify whenever we type something on searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
