//
//  MusicInformation.swift
//  Record
//
//  Created by 이지원 on 2023/02/26.
//

import SwiftUI

/**
 음악의 제목, 가수 이름을 출력하는 뷰 입니다.
 
 - parameters:
    - items: 표시하고자하는 데이터의 Binding
 */

struct MusicInformation: View {
    
    @Binding var item: Content
    
    var body: some View {
        
        VStack {
            
            // MARK: - 음악 제목
            MarqueeTextView(text: item.title ?? "", font: UIFont.customTitle3())
                .foregroundColor(Color.titleBlack)
                .font(Font.customTitle3())
                .padding(.bottom, UIScreen.getHeight(2))
                .frame(minWidth: UIScreen.getWidth(340))
            
            // MARK: - 가수 이름
            Text(item.artist ?? "")
                .foregroundColor(Color.titleDarkgray)
                .font(Font.customBody2())
                .padding(.bottom, UIScreen.getHeight(20))
                .frame(minWidth: UIScreen.getWidth(340))
        }
        .padding(.top, UIScreen.getHeight(140))
        .padding(.bottom, UIScreen.getHeight(30))
    }
}
