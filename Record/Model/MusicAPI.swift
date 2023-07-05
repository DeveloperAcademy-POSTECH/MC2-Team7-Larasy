//
//  MusicAPI.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//
// API 호출 (iTunes)

import SwiftUI

// MARK: - 음악 API 불러오기
@MainActor
final class MusicAPI: ObservableObject {
    
    // 네트워크 접근 싱글톤 객체
    static let searchMusic = MusicAPI()
    
    @Published var musicList: [Music] = []
    
    private init() {}
    
    func getSearchResults(search: String) {
        
        self.musicList = []
        
        guard var urlComponents = URLComponents(string: "https://itunes.apple.com/kr/search") else { return }
        urlComponents.query = "media=music&entity=song&term=\(search)"
        guard let url = urlComponents.url else { return }
        
        // Networking 시작
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let e = error {
                NSLog("error: \(e.localizedDescription)")
                return
            }
            
            // 값 받아오기
            DispatchQueue.main.async() { [self] in
                do {
                    
                    // JSON Parsing
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
                    guard let jsonObject = object else {
                        return
                    }
                    
                    let searchResults = jsonObject["results"] as! [NSDictionary]
                    searchResults.forEach { result in
                        
                        
                        // Music 객체에 저장
                        let searchResult = Music(artist: result["artistName"] as! String,
                                                 title: result["trackName"] as! String,
                                                 albumArt: (result["artworkUrl100"] as! String).replacingOccurrences(of: "100x100bb", with: "500x500bb"))
                        
                        self.musicList.append(searchResult)
                    }
                    
                } catch let e as NSError {
                    print("error: \(e.localizedDescription)")
                }
                
            } // DispatchQueue End
            
        } // task End
        
        task.resume()
    }
}


// MARK: 음악 정보 저장 구조체
struct Music: Hashable, Codable {
    var artist: String // 가수
    var title: String // 제목
    var albumArt: String //앨범커버
}
