//
//  CDPlayerComponent.swift
//  Record
//
//  Created by 이지원 on 2023/03/12.
//

import SwiftUI
import AVKit

struct CDPlayerComponent: View {
    
    @State private var angle = 0.0
    @State var player: AVPlayer?
    @State var isPlayMusic: Bool = false
    let music: Music
    
    var body: some View {
        ZStack {
            Image("CdPlayer")
                .padding(.trailing, 20.0)
            
            ZStack(alignment: .center) {
                Image(uiImage: getImage())
                    .resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .scaleEffect(0.46)
                    .rotationEffect(.degrees(self.angle))
                    .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                    .onTapGesture {
                        isPlayMusic ? pauseMusic() : playMusic()
                        angle += Double.random(in: 3600..<3960)
                    } // albumArt를 불러오는 URLImage
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.background)
                    .overlay(
                        Circle()
                            .stroke(.background, lineWidth: 0.1)
                            .shadow(color: .titleDarkgray, radius: 2, x: 3, y: 3)
                    )
            }.offset(x: -10.6, y: -133) // albumArt를 CD모양으로 불러오는 ZStack
            
            ZStack {
                Circle()
                    .foregroundColor(.titleLightgray)
                    .frame(width: 30 , height: 30)
                Circle()
                    .foregroundColor(.titleDarkgray)
                    .frame(width: 15 , height: 15)
                    .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                Circle()
                    .foregroundColor(.background)
                    .frame(width: 3 , height: 3)
            }.offset(x: -10.6, y: -133)
            
        }
        
    }
    
    func getImage() -> UIImage {
        
        if let url = URL(string: music.albumArt),
           let data = try? Data(contentsOf: url) {
            return UIImage(data: data)!
        } else {
            return UIImage(systemName: "xmark")!
        }
        
    }
    
    private func playMusic() {
       
        isPlayMusic.toggle()
        
        let musicURL = URL.init(string: music.previewUrl ?? "")
        
        guard let url = musicURL else {
            debugPrint("Music url is not valid")
            return
        }
        
        player = AVPlayer(playerItem: AVPlayerItem(url: url))
        
        player?.play()
        
    }
    
    private func pauseMusic() {
        isPlayMusic.toggle()
        player?.pause()
    }
}
