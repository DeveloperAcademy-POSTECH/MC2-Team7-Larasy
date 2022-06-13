//
//  TestSoiView.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/13.
//

import SwiftUI

struct TestSoiView: View {
    
    let music: Music
    
    var body: some View {
        VStack {
            Text(music.title) // 음악 이름
            Text(music.artist) // 가수 이름
            URLImage(urlString: music.albumArt) //앨범 커버
        }
    }
}
