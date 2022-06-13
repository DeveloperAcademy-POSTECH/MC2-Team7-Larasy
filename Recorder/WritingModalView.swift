//
//  WritingModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/12.
//

import SwiftUI

struct WritingModalView: View {
    
    @State var placeholderText : String = "이 음악과 관련된 짧은 이야기를\n기록해보세요 (글자수 200자 제한)"
    @State var content : String = ""
    
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
                .padding(.horizontal, 41.0)

                VStack(alignment: .trailing, spacing: 220) {
                    ZStack {
                        if self.content.isEmpty {
                            TextEditor (text: $placeholderText)
                                .font(.body)
                                .foregroundColor(.titleBlack)
                                .disabled(true)
                                .padding()
                        }
                        TextEditor (text: $content)
                            .font(.body)
                            .opacity(self.content.isEmpty ? 0.25 :1)
                            .padding()
                        } //ZStack - PlaceHolder
                    .padding(.horizontal, 15)
                    .padding(.vertical, 30)
                    .frame(width: 308, height: 350)
                    .background(Color.white)
                }
                ZStack {
                    Text("완료")
                        .font(.subheadline)
                        .foregroundColor(Color.titleGray)
                }
            }
        
        
    }
}
}


struct WritingModalView_Previews: PreviewProvider {
    static var previews: some View {
        WritingModalView()
    }
}
