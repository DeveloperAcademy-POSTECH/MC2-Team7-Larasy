//
//  Themes.swift
//  Record
//
//  Created by 전지민 on 2023/03/22.
//

import Foundation

enum Themes: CaseIterable{
    case background
    case spring
    case summer
    case fall
    case winter
    
    func fetchThemes() -> LinearGradient {
        switch self {
        case .background:
            return LinearGradient(colors: [.background], startPoint: .top, endPoint: .bottom)
        case .spring:
            return LinearGradient(colors: [Color("spring1"), Color("spring2"), Color("spring3")], startPoint: .top, endPoint: .bottom)
        case .summer:
            return LinearGradient(colors: [Color("summer1"), .white.opacity(0.7), Color("summer2")], startPoint: .top, endPoint: .bottom)
        case .fall:
            return LinearGradient(colors: [Color("fall1"), Color("fall2"), Color("fall3"), Color("fall4")], startPoint: .top, endPoint: .bottom)
        case .winter:
            return LinearGradient(colors: [Color("winter1"), Color("winter2"), Color("winter3"), Color("winter4"), .clear], startPoint: .top, endPoint: .bottom)
        }
    }
}
