//
//  PodcastCell.swift
//  Podcasts
//
//  Created by sky on 1/11/22.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            print("Loading image with url: ", podcast.artworkUrl600 ?? "")
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else { return }
            
//            URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    self?.podcastImageView.image = UIImage(data: data)
//                }
//            }.resume()
            
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
