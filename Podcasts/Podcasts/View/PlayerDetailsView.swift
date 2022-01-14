//
//  PlayerDetailsView.swift
//  Podcasts
//
//  Created by sky on 1/14/22.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            // Make the imageView shrink 30%
            let scale: CGFloat = 0.7
            episodeImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            // code to make corner radius
            episodeImageView.layer.cornerRadius = 8
            episodeImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.setImage(#imageLiteral(resourceName: "icPause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    @objc func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "icPause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "icPlay"), for: .normal)
        }
    }
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            authorLabel.text =  episode.author
            
            playEpisode()
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return}
            
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    private func playEpisode() {
        print("Trying to play episode at url", episode.streamUrl)
        
        guard let url = URL(string: episode.streamUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        // write this code to make it play immediately instead of wait a litle bit
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    private func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.episodeImageView.transform = .identity
        }
    }
}
