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
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        print("Trying to play episode", episode.title)
        
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as! PlayerDetailsView
        
        playerDetailsView.episode = episode
        playerDetailsView.frame = self.view.frame
        
        window?.addSubview(playerDetailsView)
    }
}
