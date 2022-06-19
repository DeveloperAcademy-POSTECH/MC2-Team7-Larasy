//
//  WritingModalView.swift
//  Recorder
//

//  Created by 최윤석 on 2022/06/17.
//

import SwiftUI

struct WritingModalView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var placeholderText : String = "이 음악과 관련된 짧은 이야기를\n기록해보세요 (글자수 200자 제한)"

    @Binding var content : String

    var characterLimit = 200
    
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
                
                // Modal Background Frame & Color 시작
                ZStack {
                    
                    VStack{
                        
                        // 이야기 작성 TextEditor & PlaceHolder 시작
                        ZStack {
                            if self.content.isEmpty { // PlaceHolder 출력
                                TextEditor (text: $placeholderText)
                                    .font(.customBody1())
                                    .foregroundColor(.titleGray)
                                    .disabled(true)
                                    .padding()
                            }
                            TextEditor (text: $content) // TextEditor 출력
                                .onReceive(content.publisher.collect()) {
                                    let s = String($0.prefix(characterLimit))
                                    if content != s { content = s }
                                }
                                .font(.customBody1())
                                .foregroundColor(.titleDarkgray)
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
                            
                            if self.content.isEmpty {
                                
                                Button("완료") {

                                }
                                .font(.customSubhead())
                                .foregroundColor(.titleGray)
                                
                            }
                            else {
                                Button("완료") {
                                    presentation.wrappedValue.dismiss()
                                }
                                .font(.customSubhead())
                                .foregroundColor(.pointBlue)
                            }
                            
                        }
                        .padding(20)
                        // 완료 버튼 끝

                        
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: 308, minHeight: 0, maxHeight: 350)
                .background(Color.white)
            } // Modal Background Frame & Color 끝
            
            
        }
    }
}

        
struct WritingModalView_Previews: PreviewProvider {
    static var previews: some View {
        WritingModalView(content: .constant(""))
    }
}

