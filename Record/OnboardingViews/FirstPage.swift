//
//  FirstPage.swift
//  Record
//
//  Created by 이지원 on 2022/09/25.
//

import SwiftUI

struct FirstPage: View {
    var body: some View {
        ZStack {
            
            // MARK: - Background
            
            Color.background
                .ignoresSafeArea()
            
            Image("onboarding1_1")
            
            VStack(alignment: .trailing, spacing: UIScreen.getHeight(-5)) {
                Spacer()
                    .frame(maxWidth: .infinity)
                Image("onboarding1_2")
                Image("onboarding1_3")
            }
            
            // MARK: Text
            VStack(alignment: .leading) {
                Text("나의 이야기로\n간직하고 싶은 음악이 있나요?")
                    .foregroundColor(.titleBlack)
                    .font(Font.customTitle2())
                    .lineSpacing(5)
                    .frame(width:330, alignment: .leading)
                    .padding(.leading, UIScreen.getWidth(30))
                    .padding(.top, UIScreen.getHeight(100))
                
                Spacer()
                    .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
        
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
