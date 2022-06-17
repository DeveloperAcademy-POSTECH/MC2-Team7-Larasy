//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//


import SwiftUI

struct RecordDetailView: View {
    
    let item: Content
    
    @State private var photo = false
    @State private var story = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title!)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text(item.artist!) // TODO: "music.artist"
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
                    
                    Button(action: {
                        photo.toggle()
                        UIView.setAnimationsEnabled(false)
                    },
                           label: {
                        ZStack {
                        Image("PhotoComp") // 이미지 삽입
                            .padding()
                            .fullScreenCover(isPresented: $photo, onDismiss: { photo = false }, content: { PhotoModalView() } )
                            Image(uiImage: UIImage(data: item.image!)!)
                                .resizable()
                                .frame(width: 95, height: 105)
                                .scaleEffect()
                                .offset(y: -15)
                        }
                    }).offset(y: -110)
                    //let image = UIImage(data: item.image!)
                   
                    
                    Spacer()
                    
                    CDPlayerComp(music: Music(artist: item.artist!, title: item.title!, albumArt: item.albumArt!))
                        .offset(y: -10)
                }.offset(y: 80)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Button(action: {}, label: {
                        ZStack {
                            Image("LylicComp") // 가사 입력
                            Text(item.lylic!)
                                .foregroundColor(.titleDarkgray)
                                .font(.customBody2())
                        }
                    }).offset(y: 130)
                    
                    Spacer()
                    
                    Button(action: {
                        story.toggle()
                        UIView.setAnimationsEnabled(false)
                    }, label: {
                        
                        Image("StoryComp")
                            .fullScreenCover(isPresented: $story, onDismiss: { story = false }, content: { StoryModalView() } )
                        Text(item.story!)
                            .font(Font.customBody1())
                            .foregroundColor(.titleDarkgray)
                            .lineLimit(5)
                            .truncationMode(.tail)
                            .frame(width: 130)
                            .offset(x: -160)
                    })
                    .offset(x: 20, y: -100)
                    
                    
                }.offset(y: -20)
                Spacer()
                
            }
        }.navigationBarItems(trailing:
                                
                                Menu(content: {
            Button(action: {}) { // TODO: antion내에 편집 기능 예정
                Label("편집", systemImage: "square.and.pencil")
            }
            // MARK: 이미지 저장 기능
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let image = body.screenshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }) {
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
