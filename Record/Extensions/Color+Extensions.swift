//
//  Color+Extensions.swift
//  Record
//
//  Created by 이지원 on 2022/10/05.
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
    
    static let gray9 = Color("gray9")
    static let gray8 = Color("gray8")
    static let gray6 = Color("gray6")
    static let gray3 = Color("gray3")
    static let gray2 = Color("gray2")
}

enum RecordColor {
    case recordBackground
    case recordTitleBlack
    case recordTitleDarkgray
    case recordTitleGray
    case recordTitleLightgray
    case recordBackgroundWhite
    case recordTitleWhite
    case recordShadowGray
    case recordDarkCompColor
    case recordDarkCompColor2
    
    func fetchColor(isLighting: Bool) -> Color {
        switch self {
        case .recordBackground:
            return isLighting ? .gray9 : .background
        case .recordTitleBlack:
            return isLighting ? .titleLightgray : .titleBlack
        case .recordTitleDarkgray:
            return isLighting ? .titleGray : .titleDarkgray
        case .recordTitleGray:
            return isLighting ? .gray3 : .titleGray
        case .recordTitleLightgray:
            return isLighting ? .gray8 : .titleLightgray
        case .recordBackgroundWhite:
            return isLighting ? .gray9 : .white
        case .recordTitleWhite:
            return isLighting ? .titleGray : .white
        case .recordShadowGray:
            return isLighting ? .black.opacity(0.4) : .titleDarkgray
        case .recordDarkCompColor:
            return isLighting ? .gray6 : .titleDarkgray
        case .recordDarkCompColor2:
            return isLighting ? .titleDarkgray : .titleLightgray
        }
    }
}
