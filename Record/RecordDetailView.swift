//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//


import SwiftUI
import CoreData

struct RecordDetailView: View {
    
    //coredata 관련 변수
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    let item: Content
    
    @State private var photo = false
    @State private var story = false
    @State private var deleteItemAlert = false // delete item alert
    @State private var saveImage = false
    @State private var clickEdit = false {
        willSet {
            UIView.setAnimationsEnabled(true)
        } didSet {
            DispatchQueue.main.async {
                UIView.setAnimationsEnabled(true)
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text(item.artist ?? "") // TODO: "music.artist"
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
                        UIView.setAnimationsEnabled(    false)
                    },
                           label: {
                        ZStack {
                            Image("DetailPhotoComp") // 이미지 삽입
                                .padding()
                                .fullScreenCover(isPresented: $photo, onDismiss: { photo = false }, content: { PhotoModalView(image: item.image!) } )
                            
                            if let image = item.image {
                                Image(uiImage: UIImage(data: image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 95, height: 105)
                                    .clipped()
                                    .scaleEffect()
                                    .offset(y: -15)
                            }
                        }
                    }).offset(y: -110)
                    
                    Spacer()
                    
                    CDPlayerComp(music: Music(artist: item.artist ?? "", title: item.title ?? "", albumArt: item.albumArt ?? ""))
                        .offset(x: 25, y: -10)
                }.offset(y: 80)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    ZStack {
                        Image("LylicComp") // 가사 입력
                        Text(item.lyrics ?? "")
                            .foregroundColor(.titleDarkgray)
                            .font(.customBody2())
                    }
                    .offset(y: 130)
                    
                    Spacer()
                    
                    Button(action: {
                        story.toggle()
                        UIView.setAnimationsEnabled(false)
                    }, label: {
                        
                        Image("StoryComp")
                            .fullScreenCover(isPresented: $story, onDismiss: { story = false }, content: { StoryModalView(content: item.story!) } )
                        Text(item.story ?? "")
                            .font(Font.customBody2())
                            .foregroundColor(.titleDarkgray)
                            .lineLimit(5)
                            .truncationMode(.tail)
                            .frame(width: 130)
                            .offset(x: -160)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(5)
                    })
                    .offset(x: 20, y: -100)
                    
                    
                    
                }.offset(y: -20)
                Spacer()
                
            }
            
        }
        .navigationBarItems(trailing: Menu(content: {
            
            Button(action: {
                clickEdit.toggle()
            }) { // TODO: antion내에 편집 기능 예정
                Label("편집", systemImage: "square.and.pencil")
            }
            
            // MARK: 이미지 저장 기능
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let image = body.screenshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    saveImage.toggle()
                }
            }) { Label("이미지 저장", systemImage: "square.and.arrow.down") }
            
            // MARK: 삭제 기능
            Button(role: .destructive, action: {
                deleteItemAlert = true
            }, label: {Label("제거", systemImage: "trash")})
            
        }
                                           , label: {
            Image(systemName: "ellipsis")
                .padding(.vertical, 10)
                .foregroundColor(.pointBlue)
        }))// Menu 목록 End
        .fullScreenCover(isPresented: $clickEdit) {
            NavigationView {
                WriteView(music: Music(artist: item.artist!, title: item.title!, albumArt: item.albumArt!), isEdit: .constant(true), item: item)
                    .padding(.top, -40)
            }
        }
        .alert("삭제", isPresented: $deleteItemAlert) {
            Button("삭제", role: .destructive) {
                PersistenceController.shared.deleteContent(item: item)
                presentation.wrappedValue.dismiss()
            }
        } message: { Text("정말 삭제하시겠습니까?") }
        // 본문 ZStack End
            .alert("저장완료", isPresented: $saveImage) {
                Button("확인") {
                }
            } message: {  }
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
