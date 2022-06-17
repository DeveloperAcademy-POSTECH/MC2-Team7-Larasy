//
//  RecordUIView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/16.
//

import SwiftUI

struct RecordUIView: View {
    
    var body: some View {
        
        GeometryReader { _ in
        
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
            VStack {
                HStack{
                    Spacer()
                }.padding(.trailing)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("일이삼사오육칠팔구십일이삼사오육") // TODO: "music.title"
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text("일이삼사오육칠팔구십일이삼사오육칠팔구십일") // TODO: "music.artist"
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.titleDarkgray)
                        Spacer()
                    }// MusicInform VStack End
                    .padding(.top, 10)
                    Spacer()
                } // MusicImform HStack End
                .padding(.leading, 28)
            }
            
            ZStack {
                HStack(alignment: .center) {
                    Image("PhotoComp") // 이미지 삽입
                        .padding()
                        .offset(y: -110)
                    
                    Spacer()
                    
                    CDPlayerComp(music: Music(artist: "sunwoojunga", title: "Cat (feat.IU)", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"))
                        .offset(y: -10)
                }.offset(y: 80)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Image("LylicComp") // 가사 입력
                        .offset(y: 130)
                    
                    Spacer()
                    
                    
                    Image("StoryComp") // 스토리 입력
                        .offset(x: 20,y: -100)
                    
                    
                }.offset(y: -20)
                Spacer()
                
            }
        }// 본문 ZStack End
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct RecordBackground: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("backwindow")
            }.padding(.top, 60.0)
            Spacer()
        }
    }
}

struct RecordUIView_Previews: PreviewProvider {
    static var previews: some View {
        RecordUIView()
    }
}
