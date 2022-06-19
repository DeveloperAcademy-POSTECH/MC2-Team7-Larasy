//
//  StoryModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/15.
//

import SwiftUI

struct StoryModalView: View {
    
    @Environment(\.presentationMode) var presentation
    let content: String
    
    var body: some View {
        ZStack {
            Color.titleBlack //Background Color
                .opacity(0.95)
                .ignoresSafeArea()
            
            VStack {
                
                // 나의 음악 이야기 & x 버튼 시작
                HStack {
                    Text("나의 음악 이야기") // 상단 나의 음악 이야기 Text 텍스트 출력
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
                // 나의 음악 이야기 & x 버튼 시작 끝
                
                // 본문 Frame & Text 시작
                ZStack{
                    Rectangle() // 본문 Background
                        .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 350)
                        .foregroundColor(.white)
                    
                    Text(content) // 본문내용
                        .foregroundColor(.titleDarkgray)
                        .font(.customBody1())
                        .frame(width:256, alignment: .leading)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .lineSpacing(7)
                    
                }
            } // 본문 Frame & Text 끝
        }
    }
}

//struct StoryModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryModalView()
//            .previewInterfaceOrientation(.portrait)
//    }
//}
