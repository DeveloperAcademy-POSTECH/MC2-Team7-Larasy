//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//


import SwiftUI

struct RecordDetailView: View {
    
    let music: Music
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(music.title) // TODO: "music.title"
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text(music.artist) // TODO: "music.artist"
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
                    
                    Button(action: {}, // TODO: action 내에 클릭시 모달을 통해 이미지 띄우는 기능 추가 예정
                           label: {
                        Image("PhotoComp") // 이미지 삽입
                            .padding()
                    }).offset(y: -110)
                    Spacer()
                    
                        CDPlayerComp(music: Music(artist: "sunwoojunga", title: "Cat (feat.IU)", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"))
                    .offset(y: -10)
                }.offset(y: 80)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Button(action: {}, label: { // TODO: action 내에 클릭시 모달을 통해 이미지 띄우는 기능 추가 예정
                        Image("LylicComp") // 가사 입력
                    }).offset(y: 130)
                    
                    Spacer()
                    
                    Button(action: {}, label: { // TODO: action 내에 클릭시 모달을 통해 StoryView 추가 예정
                        Image("StoryComp") // 스토리 입력
                    }).offset(x: 20,y: -100)
                    
                    
                }.offset(y: -20)
                Spacer()
                
            }
        }.navigationBarItems(trailing:
            Menu(content: {
                Button(action: {}) { // TODO: antion내에 편집 기능 예정
                    Label("편집", systemImage: "square.and.pencil")
                }
                Button(action: {}) { // TODO: Soi코딩 중인 스크린샷 기능 예정
                    Label("이미지 저장", systemImage: "square.and.arrow.down")
                }
                Button(role: .destructive, action: {}) { // TODO: action에 삭제 Alert띄우기 및 삭제 기능 예정
                    Label("제거", systemImage: "trash")
                }
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.pointBlue)
            }))
        // 본문 ZStack End
    }
}

struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView(music: Music(artist: "sunwoojunga", title: "Cat (feat.IU)", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"))
    }
}

struct CDPlayerComp: View {
    
    let music: Music
    @State private var angle = 0.0
    var body: some View {
        ZStack {
            Image("CdPlayer")
                .padding(.trailing, 20.0)
                
            ZStack(alignment: .center) {
                URLImage(urlString: music.albumArt)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .scaleEffect(0.46)
                    .rotationEffect(.degrees(self.angle))
                    .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                    .onTapGesture {
                        self.angle += Double.random(in: 3600..<3960)
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
            
        }// ZStack End
    }
}
