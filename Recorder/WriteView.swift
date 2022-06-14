//
//  WriteView.swift
//  Recorder
//
//  Created by 최윤석 on 2022/06/13.
//

import SwiftUI

struct WriteView: View {
    @State private var image: Image?                        // 선택된 사진, 어떤 이미지인지
    @State private var showingImagePicker = false   // 클릭됐는지 확인
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
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
                        
                        ZStack{ // TODO: action 내에 클릭시 모달을 통해 이미지 띄우는 기능 추가 예정
                            
                            Image("PhotoComp") // 이미지 삽입
                                .padding()
                            
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                                .offset(y: -15)
                            
                            image?
                                .resizable()
                                .frame(width: 95, height: 105)
                                .scaleEffect()
                                .offset(y: -15)
                            
                        }
//                        .frame(width: 150, height: 120)
                        .onTapGesture {
                            showingImagePicker = true
                        }
                        .offset(y: -70)
                        .zIndex(1)
                        
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
                    
                }.onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
            }// 본문 ZStack End
            .navigationBarItems(leading: NavigationLink(destination: SearchView(), label: {
                Image(systemName: "chevron.backward")
                Text("Music")
            }))
            
        } // Navigation View 출력
    } // View End
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
} // RecordResultView End

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView()
    }
}
