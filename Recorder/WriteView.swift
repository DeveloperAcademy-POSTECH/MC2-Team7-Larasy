//
//  WriteView.swift
//  Recorder
//
//  Created by 최윤석 on 2022/06/13.
//

import SwiftUI

struct WriteView: View {
    @State var music: Music
    @State private var image: Image?                       // 선택된 사진, 어떤 이미지인지
    @State private var showingImagePicker = false           // 이미지 클릭됐는지 확인
    @State private var savestory = false                    // 이야기 클릭됐는지 확인
    @State private var inputImage: UIImage?
    @State private var lyrics = ""
    @State private var content = ""
    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                RecordBackground()
                VStack{
                    HStack{
                        Spacer()
                    }.padding(.trailing)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(music.title)") // MARK: "music.title"
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text("\(music.artist)") //MARK: "music.artist"
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.titleDarkgray)
                        Spacer()
                    }// MusicInform VStack End
                    .padding(.top, 10)
                    Spacer()
                } // MusicImform HStack End
                .padding(.leading, 28)
                
                ZStack {
                    HStack(alignment: .center) {
                        //MARK: - // 클릭시 모달을 통해 이미지 띄우는 부분
                        ZStack{
                            Image("PhotoComp")
                                .padding()
                            
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                                .offset(y: -15)
                            
                            image?                       // 사용자가 가져온 이미지를 보여주는 부분
                                .resizable()
                                .frame(width: 95, height: 105)
                                .scaleEffect()
                                .offset(y: -15)
                            
                        }
                        .onTapGesture {
                            showingImagePicker = true
                        }
                        .offset(y: -110)
                        .zIndex(1)
                        .onChange(of: inputImage) { _ in loadImage() }
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                        //MARK: - 이미지 가져오는 부분 끝
                        Spacer()
                        
                        //MARK: - CD 플레어이 뷰 시작
                        
                        CDPlayerComp(music: music) //MARK: SearchView에서 music 받아옴
                            .offset(y: -10)
                    }.offset(y: 80)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        
                        //MARK: - 가사 입력 받는 뷰 시작
                        ZStack {
                            Image("LylicComp") // 가사 입력
                                .offset(y: 130)
                            HStack{
                                
                                if lyrics == "" {
                                    Image(systemName: "music.mic")
                                        .offset(x: 55)
                                        .foregroundColor(.titleGray)
                                }
                                
                                TextField("기억하고 싶은 가사",         // 가사 입력하는 텍스트 필드
                                          text: $lyrics)
                                .font(Font.customBody1())
                                .disableAutocorrection(true)
                                .multilineTextAlignment(.center)
                                .frame(width: 240,alignment: .center)
                                
                            }
                            .offset(y: 130)
                        }
                        
                        Spacer()
                        
                        // MARK: - 모달을 통해 이야기 작성하는 뷰 시작
                        Button(action: { savestory.toggle()
                            UIView.setAnimationsEnabled(false)},
                               label: {
                            Image("StoryComp") // 스토리 입력
                                .fullScreenCover(isPresented: $savestory, onDismiss: { savestory = false }, content: {
                                    WritingModalView(content: $content)
                                })
                            if !content.isEmpty {
                                Text(content)
                                    .font(Font.customBody1())
                                    .foregroundColor(.titleDarkgray)
                                    .lineLimit(5)
                                    .truncationMode(.tail)
                                    .frame(width: 130)
                                    .offset(x: -160)
                            }
                        })
                        .offset(x: 20,y: -100)
                        //MARK: - 이야기 입력 받는 Button 끝
                    }.offset(y: -20)
                    
                    Spacer()
                    
                }
            }.navigationBarItems( trailing: NavigationLink(destination: EmptyView(), label: {
                Text("저장")                              // TODO: 저장 기능 추가 예정
                    .font(Font.customSubhead())
            }))
        }.ignoresSafeArea(.keyboard, edges: .bottom)
        
    } // View End
    
    func loadImage() {      // 이미지 저장하는 함수
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
} // RecordResultView End

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(music: Music(artist: "sunwoojunga", title: "Cat (feat.IU)", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"))
    }
}