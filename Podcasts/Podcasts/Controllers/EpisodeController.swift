//
//  EpisodeController.swift
//  Podcasts
//
//  Created by sky on 1/12/22.
//

import UIKit
import FeedKit

class EpisodeController: UITableViewController {
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            
            fetchEpisode()
        }
    }
    
    private func fetchEpisode() {
        print("Looking for episodes at feed url:", podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        // Because feedURL is not JSON format. It is XML format. We need to use FeedKit to parse data from XML
        let parser = FeedParser(URL: url)
        parser?.parseAsync(result: { (result) in
            print("Successfully parse feed:", result.isSuccess)
            
            // associative enumeration values
            switch result {
                case let .rss(feed):        // Really Simple Syndication Feed Model
                    
                    var episodes = [Episode]() // blank Episode
                    
                    feed.items?.forEach({ (feedItem) in
                        let episode = Episode(feedItem: feedItem)
                        episodes.append(episode)
                    })
                    self.episodes = episodes
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case let .failure(error):
                    print("Failed to parse feed:", error)
                    break
            default:
                print("Found a feed")
                }
        })
    }
    
    private var cellId = "EpisodeCell"
    
    var episodes = [Episode]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK:- Setup work
    
    private func setupTableView() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    // MARK:- UITableView Datasource & Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        
        cell.episode = episode
        
        return cell
    }
}
