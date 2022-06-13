//
//  MusicAPI.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//
// API 호출 (iTunes)

import SwiftUI

class ViewModel: ObservableObject {
    @Published var musicList: [Music] = []
    
    func getSearchResults(search: String) {
        
        self.musicList = []
        
        guard var urlComponents = URLComponents(string: "https://itunes.apple.com/search") else { return }
        
        urlComponents.query = "media=music&entity=song&term=\(search)"
        
        guard let url = urlComponents.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let e = error {
                NSLog("error: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
                    guard let jsonObject = object else { return }
                    
                    let searchResults = jsonObject["results"] as! [NSDictionary]
                    searchResults.forEach { result in
                        let searchResult = Music(artistName: result["artistName"] as! String,
                                                 trackName: result["trackName"] as! String,
                                                 albumName: result["collectionName"] as! String,
                                                 releaseDate: result["releaseDate"] as! String,
                                                 previewUrl: result["previewUrl"] as! String,
                                                 artworkUrl100: result["artworkUrl100"] as! String)
                        
                        self.musicList.append(searchResult)
                    }
                    
                } catch let e as NSError {
                    print("error: \(e.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}


struct Music: Hashable, Codable {
    var artistName: String
    var trackName: String
    var albumName: String
    var releaseDate: String
    var previewUrl: String
    var artworkUrl100: String
}
