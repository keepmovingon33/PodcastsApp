//
//  PodcastViewController.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

import UIKit
import Alamofire

class PodcastSearchController: UITableViewController {
    
    var podcasts = [Podcast]()
    
    let cellId = "CellId"
    
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
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    
    // MARK:- UITableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}

// MARK:- UISearchBarDelegate Methods

// After we assign delegate for searchBar, We need to conform UISearchBarDelegate and write implementation for some func so that we could get notified after we type something in SearchBar
extension PodcastSearchController: UISearchBarDelegate {
    
    // This func will notify whenever we type something on searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(searchText: searchText) { [weak self] podcasts in
            self?.podcasts = podcasts
            self?.tableView.reloadData()
        }
        
       
    }
}
