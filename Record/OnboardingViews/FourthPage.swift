//
//  FourthPath.swift
//  Record
//
//  Created by 이지원 on 2022/09/25.
//

import SwiftUI

struct FourthPage: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("음악 기록가가 되신 것을\n환영합니다!")
                    .foregroundColor(.titleBlack)
                    .font(Font.customTitle2())
                    .lineSpacing(5)
                    .padding(.leading, UIScreen.getWidth(30))
                    .padding(.top, UIScreen.getHeight(100))
                
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            VStack {
                Image("onboarding4")
            }
        }
        .ignoresSafeArea()
    }
}

struct FourthPath_Previews: PreviewProvider {
    static var previews: some View {
        FourthPage()
    }
}
