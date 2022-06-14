//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//

import SwiftUI

struct RecordDetailView: View {
    
//    let music: Music
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Image("backwindow")
                }.padding(.top, 70.0)
                Spacer()
            } // BackgroundView용 VStack End
            HStack {
                VStack(alignment: .leading) {
                    Text("Dun Dun Dance") // "music.title"
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.titleBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                    
                    Text("오마이걸(OH MY GIRL)") // "music.artist"
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.titleDarkgray)
                    Spacer()
                }// MusicInform VStack End
                .padding()
                Spacer()
            }.padding() // MusicImform HStack End
            VStack {
    
                HStack(alignment: .center) {
                        Image("PhotoComp") // 이미지 삽입
                        .padding()
                        .offset(y: -70)
                        Spacer()
                        Image("CdPlayer")
                            .padding(.trailing, 20.0)
                    }.offset(y: 110)
                    .padding()
                    VStack(alignment: .leading) {
                        Spacer()
                        Image("StoryComp") // 스토리 입력
                            .offset(x: 20,y: -50)
                        Image("LylicComp") // 가사 입력
                            .offset(y: -30)
                    }.offset(y: -20)
            Spacer()
            
            }
            }// 본문 ZStack End
    }
}

struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView()
    }
}
