//
//  Podcast.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

import Foundation
import FeedKit

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Podcast]
}

struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    
    let imageUrl: String?
    
    // because we fetch episode data from RSS XML, not JSON, that's why we have RSSFeedItem here
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}
