//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by sky on 1/12/22.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode! {
        didSet {
            
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDate.text =  dateFormatter.string(from: episode.pubDate)
            
            let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "")
            
            // load hinh vo cache de khoi phai load hinh nhieu lan
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var episodeImageView: UIImageView!
    
}
