//
//  SecondPage.swift
//  Record
//
//  Created by 이지원 on 2022/09/25.
//

import SwiftUI

struct SecondPage: View {
    var body: some View {
        ZStack {
            
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(maxWidth: .infinity)
                
                Image("onboarding2_1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.getWidth(213), height: UIScreen.getHeight(63))
                    .padding(.bottom, UIScreen.getHeight(25))
                    .padding(.leading, UIScreen.getWidth(-120))
                
                HStack(spacing: UIScreen.getWidth(120)) {
                    Image("onboarding2_2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(117))
                        .padding(.top, UIScreen.getHeight(50))
                    Image("onboarding2_3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.getWidth(140), height: UIScreen.getHeight(130))
                }
                .padding(.leading, UIScreen.getWidth(100))
                .padding(.bottom, UIScreen.getHeight(40))
                
                VStack(alignment: .trailing, spacing: UIScreen.getHeight(-5)) {
                    HStack(alignment: .bottom) {
                        Image("onboarding2_4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(67))
                        Image("onboarding2_5")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.getWidth(203), height: UIScreen.getHeight(156))
                    }
                    
                    Image("onboarding2_6")
                        .frame(maxWidth: UIScreen.screenWidth)
//                        .padding(.leading, 40)
                }
            }
            .frame(maxWidth: UIScreen.screenWidth)
            
            // MARK: Text
            VStack(alignment: .leading) {
                Text("음악을 사진과 함께\n짧은 이야기로 기록하고,\n기억하고 싶은 가사를 입력하세요.")
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

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage()
    }
}
