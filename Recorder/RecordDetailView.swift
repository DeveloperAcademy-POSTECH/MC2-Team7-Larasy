//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//

import SwiftUI

struct RecordDetailView: View {
    
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
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
                .padding(.leading, 5)
                Spacer()
            } // MusicImform HStack End
            .padding(.leading, 23)
            VStack {
                
                HStack(alignment: .center) {
                    
                    Button(action: {}, // TODO: action 내에 클릭시 모달을 통해 이미지 띄우는 기능 추가 예정
                           label: {
                        Image("PhotoComp") // 이미지 삽입
                            .padding()
                    }).offset(y: -70)
                    Spacer()
                    
                    Button(action: {}, label: { // TODO: CD돌아가는 애니메이션 출력..?
                        Image("CdPlayer")
                            .padding(.trailing, 20.0)
                    })
                }.offset(y: 110)
                    .padding()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Button(action: {}, label: { // TODO: action 내에 클릭시 모달을 통해 StoryView 추가 예정
                        Image("StoryComp") // 스토리 입력
                    }).offset(x: 20,y: -50)
                    
                    Button(action: {}, label: { // TODO: action 내에 클릭시 모달을 통해 이미지 띄우는 기능 추가 예정
                        Image("LylicComp") // 가사 입력
                    }).offset(y: -30)
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

struct RecordBackground: View {
    var body: some View {
    VStack {
        HStack {
            Spacer()
            Image("backwindow")
        }.padding(.top, 70.0)
        Spacer()
    }
}
}
