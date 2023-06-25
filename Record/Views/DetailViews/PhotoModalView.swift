//
//  PhotoModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/16.
//

import SwiftUI

struct PhotoModalView: View {
    
    @Binding var isPresented: Bool
    let image: Data

    var body: some View {
        ZStack {
            Color.titleBlack //Background Color
                .opacity(0.95)
                .ignoresSafeArea()
                .onTapGesture {
                    self.isPresented = false
                }
            VStack {
                
                // 나의 음악 사진 & x 버튼 시작
                HStack {
                    Text("나의 음악 사진") // 상단 나의 음악 사진 Text 텍스트 출력
                        .foregroundColor(.white)
                        .font(.customTitle2())
                    Spacer()
                    
                    Button {
                        withAnimation {
                            self.isPresented = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                }
                // 나의 음악 사진 & x 버튼 시작 끝
                
                // 본문 Frame & Photo 시작
                ZStack{
                    Rectangle() // 본문 Background
                        .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 435)
                        .foregroundColor(.white)
                    
                    
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .frame(minWidth: 0, maxWidth: 276 , minHeight: 0, maxHeight: 314)
                        .scaledToFill()
                        .padding(.top, 16)
                        .padding(.bottom, 103)
                }
            } // 본문 Frame & Photo 끝
            .frame(minWidth: 0, maxWidth: 308)
        }
        .navigationBarBackButtonHidden(isPresented)
        .onDisappear {
            UIView.setAnimationsEnabled(true)
        }
    }
}
