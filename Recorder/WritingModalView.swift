//
//  WritingModalView.swift
//  Recorder
//
//  Created by MINJI on 2022/06/12.
//

import SwiftUI

struct WritingModalView: View {
    var body: some View {
        ZStack {
            Color("black")
                .opacity(0.95)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("나의 음악 이야기")
                        .foregroundColor(.white)
                        .font(.title2)
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)

                }
                .padding(.horizontal, 41.0)
                
                VStack(alignment: .trailing, spacing: 220) {
                    Text("이 음악과 관련된 짧은 이야기를\n기록해보세요 (글자수 200자 제한)")
                    .font(.body)
                    .foregroundColor(Color.titleGray)
                    .frame(width: 256, alignment: .topLeading)
                    //.lineSpacing(25)

                    Text("완료")
                    .font(.subheadline)
                    .foregroundColor(Color.titleGray)
                    //.lineSpacing(22)
                }
                .padding(.leading, 25)
                .padding(.trailing, 19)
                .padding(.top, 38)
                .padding(.bottom, 20)
                .frame(width: 308, height: 350)
                .background(Color.white)
                

            }
        }
    }
}

struct WritingModalView_Previews: PreviewProvider {
    static var previews: some View {
        WritingModalView()
    }
}
