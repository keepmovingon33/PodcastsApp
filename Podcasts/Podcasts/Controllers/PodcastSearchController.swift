//
//  PodcastViewController.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

import UIKit
import Alamofire

class PodcastSearchController: UITableViewController {
    
    var podcasts = [
        Podcast(trackName: "Swift UIKit", artistName: "Andy"),
        Podcast(trackName: "SwiftUI", artistName: "Daniel")
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
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "\(podcasts[indexPath.row].trackName ?? "")  \n \(podcasts[indexPath.row].artistName ?? "")"
        cell.imageView?.image = #imageLiteral(resourceName: "icPodcast")
        cell.textLabel?.numberOfLines = -1
        return cell
    }
    
    struct SearchResult: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
}

// MARK:- UISearchBarDelegate Methods

// After we assign delegate for searchBar, We need to conform UISearchBarDelegate and write implementation for some func so that we could get notified after we type something in SearchBar
extension PodcastSearchController: UISearchBarDelegate {
    
    // This func will notify whenever we type something on searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // original url: url = "https://itunes.apple.com/search?term=\(searchText)"
        
        let url = "https://itunes.apple.com/search"
        // we have an issue. When we search "Brian Voong", the url will have a space, which will only fetch the keyword Brian, not Brian Voong as we wanted. So we fix it by doing this:
        // encoding: URLEncongding.default se giup convert space "Brian Voong" thanh "Brian+voong"
        let parameters = ["term": searchText]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to connect yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                searchResult.results.forEach { [weak self] (pod) in
                    self?.podcasts = searchResult.results
                    self?.tableView.reloadData()
                }
            } catch let err {
               print("Failed to decode:", err)
            }
        }
    }
}
