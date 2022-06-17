//
//  PhotoModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/16.
//

import SwiftUI

struct PhotoModalView: View {
    
    @Environment(\.presentationMode) var presentation
    let image: Data

    var body: some View {
        ZStack {
            Color.titleBlack //Background Color
                .opacity(0.95)
                .ignoresSafeArea()
            
            VStack {
                
                // 나의 음악 사진 & x 버튼 시작
                HStack {
                    Text("나의 음악 사진") // 상단 나의 음악 사진 Text 텍스트 출력
                        .foregroundColor(.white)
                        .font(.customTitle2())
                    Spacer()
                    
                    Button(action: { // 상단 X 버튼
                        presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    } // 상단 X 버튼 끝
                    
                    
                }
                .padding(.horizontal, 48.0)
                // 나의 음악 사진 & x 버튼 시작 끝
                
                // 본문 Frame & Photo 시작
                ZStack{
                    Rectangle() // 본문 Background
                        .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 435)
                        .foregroundColor(.white)
                    
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaleEffect()
                        .frame(minWidth: 0, maxWidth: 276, minHeight: 0, maxHeight: 314)
                        .padding(.top, 16)
                        .padding(.bottom, 103)
                    
                }
            } // 본문 Frame & Photo 끝
        }
    }
}
//
//struct PhotoModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoModalView()
//    }
//}
