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
                
                // 나의 음악 이야기 & x 버튼 시작
                HStack {
                    Text("나의 음악 이야기")
                        .foregroundColor(.white)
                        .font(.customTitle2())
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 48.0) //41이 양쪽 마진 딱 맞음
                // 나의 음악 이야기 & x 버튼 시작 끝
                
                // Modal Background Frame & Color 시작
                ZStack {
                    VStack{
                        
                        // 이야기 작성 TextEditor & PlaceHoler 시작
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
                            
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 30)
                        .padding(.bottom, 50.0)
                        // 이야기 작성 TextEditor & PlaceHoler 끝
                        
                        // 완료 버튼 시작
                        HStack {
                            Spacer()

                            Button("완료") {
                                
                            }
                            .disabled(true)
                        }
                        .padding(20)
                        // 완료 버튼 끝(날예정)
                    
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 350)
                .background(Color.white)
            } // Modal Background Frame & Color 끝
            
            
        } // Background Color
    }
}


struct WritingModalView_Previews: PreviewProvider {
    static var previews: some View {
        WritingModalView()
    }
}

