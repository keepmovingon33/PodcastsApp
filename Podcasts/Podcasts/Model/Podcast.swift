//
//  Podcast.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

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
