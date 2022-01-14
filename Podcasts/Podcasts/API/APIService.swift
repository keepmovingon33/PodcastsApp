//
//  APIService.swift
//  Podcasts
//
//  Created by sky on 1/11/22.
//

import Alamofire
import Foundation
import FeedKit

class APIService {
    
    //singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> Void) {
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        // Because feedURL is not JSON format. It is XML format. We need to use FeedKit to parse data from XML
        let parser = FeedParser(URL: url)
        parser?.parseAsync(result: { (result) in
            print("Successfully parse feed:", result.isSuccess)
            
            if let err = result.error {
                print("Failed to parse XML feed:", err)
                return
            }
            
            guard let feed = result.rssFeed else { return }
            
            let episodes = feed.toEpisodes()
            completionHandler(episodes)
        })
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> Void) {
        
        // original url: url = "https://itunes.apple.com/search?term=\(searchText)"
        
        let url = "https://itunes.apple.com/search"
        // we have an issue. When we search "Brian Voong", the url will have a space, which will only fetch the keyword Brian, not Brian Voong as we wanted. So we fix it by doing this:
        // encoding: URLEncongding.default se giup convert space "Brian Voong" thanh "Brian+voong"
        // when we pass parameter "media": "podcast" -> we only want to load podcast files, not all the music files
        let parameters = ["term": searchText, "media": "podcast"]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to connect yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                searchResult.results.forEach { [weak self] (pod) in
                    completionHandler(searchResult.results)
                }
            } catch let err {
               print("Failed to decode:", err)
            }
        }
    }
}
