//
//  RSSFeed.swift
//  Podcasts
//
//  Created by sky on 1/13/22.
//

import FeedKit

extension RSSFeed {
    
    func toEpisodes() -> [Episode] {
        
        // image from podcast
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        var episodes = [Episode]() // blank Episode
        
        // feedItem is from episode. So the image we try to fetch is from episode, which we don't know if it is exist or not
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            episodes.append(episode)
        })
        
        return episodes
    }
}
