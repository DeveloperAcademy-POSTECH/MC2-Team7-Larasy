//
//  Extension.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//

import SwiftUI

extension Color {
    // 피그마에 등록된 색상 보시고, 사용하시면 됩니다!
    // foreground(.titleBlack) 이런식으로 사용하시면 돼요!
    
    //title 색상
    static let titleBlack = Color("black")
    static let titleDarkgray = Color("darkgray")
    static let titleGray = Color("gray")
    static let titleLightgray = Color("lightgray")
    
    //point color
    static let pointBlue = Color("blue")
    static let pointOrange = Color("orange")
    static let pointYellow = Color("yellow")
    
    //etc
    static let background = Color("background")
    static let cdplayer = Color("cdplayer")
}

extension Font {
    // 피그마에 사용된 폰트 보시고, 사용하시면 됩니다!
    // font(Font.customTitle1()) 이런식으로 사용하시면 돼요!
    
    static func customLargeTitle() -> Font {
        return Font.system(size: 34, weight: .heavy)
    }
    static func customTitle1() -> Font {
        return Font.system(size: 28, weight: .semibold)
    }
    static func customTitle2() -> Font {
        return Font.system(size: 24, weight: .bold)
    }
    static func customTitle3() -> Font {
        return Font.system(size: 20, weight: .regular)
    }
    static func customHeadline() -> Font {
        return Font.system(size: 17, weight: .bold)
    }
    static func customBody1() -> Font {
        return Font.system(size: 17, weight: .regular)
    }
    static func customBody2() -> Font {
        return Font.system(size: 15, weight: .regular)
    }
    static func customSubhead() -> Font {
        return Font.system(size: 15, weight: .bold)
    }
    static func customFootnote() -> Font {
        return Font.system(size: 13, weight: .regular)
    }
}
