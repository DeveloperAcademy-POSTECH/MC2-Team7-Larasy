//
//  WritingModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/12.
//

import SwiftUI
import Combine

struct WritingModalView: View {
    
    @State var placeholderText : String = "이 음악과 관련된 짧은 이야기를\n기록해보세요 (글자수 200자 제한)"
    @State var content : String = ""
    var characterLimit = 200
    
    var body: some View {
        ZStack {
            Color("black")
                .opacity(0.95)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("나의 음악 이야기")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)
                    
                } // HStack - 나의 음악 이야기 & x 버튼
                .padding(.horizontal, 48.0) //41이 양쪽 마진 딱 맞음
                
                ZStack {
                    VStack{
                        
                        ZStack {
                            if self.content.isEmpty {
                                TextEditor (text: $placeholderText)
                                    .font(.body)
                                    .foregroundColor(.titleBlack)
                                    .disabled(true)
                                    .padding()
                            }
                            TextEditor (text: $content)
                                .onReceive(content.publisher.collect()) {
                                    let s = String($0.prefix(characterLimit))
                                    if content != s { content = s }
                                }
                                .font(.body)
                                .opacity(self.content.isEmpty ? 0.25 :1)
                                .padding()
                            
                        } //ZStack - PlaceHolder
                        .padding(.horizontal, 15)
                        .padding(.top, 30)
                        .padding(.bottom, 50.0)
                        
                        HStack {
                            Spacer()

                            Button("완료") {
                                
                            }
                            .disabled(true)
                        } // HStack - 완료
                        .padding(20)
                    } // text editor & 완료
                    
                }
                .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 350) // 프레임 크기 설정
                .background(Color.white) // 프레임 컬러 설정
            } // 전체 Modal
            
            
        } // Background Color
    }
}


struct WritingModalView_Previews: PreviewProvider {
    static var previews: some View {
        WritingModalView()
    }
}
