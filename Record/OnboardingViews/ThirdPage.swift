//
//  ThirdPage.swift
//  Record
//
//  Created by 이지원 on 2022/09/25.
//

import SwiftUI

struct ThirdPage: View {
    var body: some View {
        
        
        ZStack {
            
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: UIScreen.getWidth(70)) {
                    VStack {
                        Image("onboarding3_1")
                            .offset(x: UIScreen.getWidth(-30), y: UIScreen.getHeight(8))
                        Image("onboarding3_3")
                            .offset(x:UIScreen.getWidth(25), y: UIScreen.getHeight(100))
                    }
                    Image("onboarding3_2")
                                            .padding(.bottom, UIScreen.getHeight(50))
                        .offset(x: UIScreen.getWidth(-60))
                }
                
                VStack(alignment: .leading) {
                    Image("onboarding3_4")
                        .padding(.trailing, UIScreen.getWidth(150))
                }
                .frame(maxWidth: UIScreen.screenWidth)
            }
            .frame(maxHeight: UIScreen.screenHeight)
            
            // MARK: Text
            VStack(alignment: .leading) {
                Text("나만의 방에서\n음악을 플레이어에 재생시키고\n기록을 다시 감상하세요.")
                    .foregroundColor(.titleBlack)
                    .font(Font.customTitle2())
                    .lineSpacing(5)
                    .padding(.leading, UIScreen.getWidth(30))
                    .padding(.top, UIScreen.getHeight(100))
                
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
        }
        .ignoresSafeArea()
    }
}

struct ThirdPage_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPage()
    }
}
