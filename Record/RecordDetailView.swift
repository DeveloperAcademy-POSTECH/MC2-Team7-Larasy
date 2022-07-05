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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Content>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
    
    @State var item: Content?
    @State private var photo = false
    @State private var story = false
    @State private var deleteItemAlert = false // delete item alert
    @State private var saveImage = false
    @State var clickEdit = false
    @State var isEdit = true
    let index: Int
    
    var body: some View {
        
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RecordBackground()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(items[index].title ?? "") // 노래 제목
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                            
                        Text(items[index].artist ?? "") // 가수 명
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
                            Image("DetailPhotoComp") // 이미지
                                .padding()
                                .fullScreenCover(isPresented: $photo, onDismiss: { photo = false }, content: {
                                    PhotoModalView(image: items[index].image!) } )
                            
                            if let image = items[index].image {
                                Image(uiImage: UIImage(data: image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 95, height: 105)
                                    .clipped()
                                    .scaleEffect()
                            }
                        }
                    })
                    .padding(.bottom, 240)
                    
                    Spacer()
                    
                    CDPlayerComp(music:
                                    Music(artist: item!.artist ?? "",
                                          title: item!.title ?? "",
                                          albumArt: item!.albumArt ?? ""))
                        .offset(x: 25, y: -10)
                }.offset(y: 80)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    ZStack {
                        Image("LylicComp") // 가사 입력
                        //Text(lyric)
                        Text(item!.lylic ?? "")
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
                                .fullScreenCover(isPresented: $story,
                                                 onDismiss: { story = false },
                                                 content: { StoryModalView(content: item!.story!) } )
                            
                            Text(item!.story ?? "") // 이야기
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
            
            // MARK: 글 편집 기능
            Button(action: {
                clickEdit.toggle()
            }) {
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
            
        }, label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.pointBlue)
        }))// Menu 목록 End
        
        .alert("삭제", isPresented: $deleteItemAlert) {
            Button("삭제", role: .destructive) {
                deleteItem()
                presentation.wrappedValue.dismiss()
            }
        } message: { Text("정말 삭제하시겠습니까?") }
        // 본문 ZStack End
            .alert("저장완료", isPresented: $saveImage) {
                Button("확인") {
                }
            } message: {  }
        // 본문 ZStack End
        
        // 편집화면으로 이동
            .fullScreenCover(isPresented: $clickEdit) {
                NavigationView{
                    WriteView(userContent: getUserContent(item!), isEdit: $clickEdit, item: $item)
                        .padding(.top, -40)
                }
            }
        
    }
    
    
    func deleteItem() {
        self.managedObjectContext.delete(self.item!)
        do {
            try self.managedObjectContext.save()
            self.presentation.wrappedValue.dismiss()
        }catch{
            print(error)
        }
    }
    
    func getUserContent(_ item: Content) -> UserContent {
        let img = Image(uiImage: UIImage(data: item.image ?? Data()) ?? UIImage())
        return UserContent(music:
                            Music(artist: item.artist ?? "",
                                  title: item.title ?? "",
                                  albumArt: item.albumArt ?? ""),
                           lyric: item.lylic ?? "",
                           image: img,
                           story: item.story ?? "")
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
