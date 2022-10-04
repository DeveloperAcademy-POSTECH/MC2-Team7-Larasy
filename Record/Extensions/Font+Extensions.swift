//
//  Font+Extensions.swift
//  Record
//
//  Created by 이지원 on 2022/10/05.
//

import SwiftUI

extension Font {
    // 피그마에 사용된 폰트 보시고, 사용하시면 됩니다!
    // font(Font.customTitle1()) 이런식으로 사용하시면 돼요!
    
    static func customLargeTitle() -> Font {
        return Font.system(size: 34 * setSize(), weight: .heavy)
    }
    static func customTitle1() -> Font {
        return Font.system(size: 28 * setSize(), weight: .semibold)
    }
    static func customTitle2() -> Font {
        return Font.system(size: 24 * setSize(), weight: .bold)
    }
    static func customTitle3() -> Font {
        return Font.system(size: 20 * setSize(), weight: .regular)
    }
    static func customHeadline() -> Font {
        return Font.system(size: 17 * setSize(), weight: .bold)
    }
    static func customBody1() -> Font {
        return Font.system(size: 17 * setSize(), weight: .regular)
    }
    static func customBody2() -> Font {
        return Font.system(size: 15 * setSize(), weight: .regular)
    }
    static func customSubhead() -> Font {
        return Font.system(size: 15 * setSize(), weight: .bold)
    }
    static func customFootnote() -> Font {
        return Font.system(size: 13 * setSize(), weight: .regular)
    }
    
    static func setSize() -> Double {
        let height = UIScreen.screenHeight
        var size = 1.0
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            size = 0.85
            break
        case 568.0: //iphone 5, SE => 4 inch
            size = 0.9
            break
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            size = 0.9
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            size = 0.95
            break
        case 812.0: //iphone X, XS => 5.8 inch, 13 mini, 12, mini
            size = 0.98
            break
        case 844.0: // iphone 14, iphone 13 pro, iphone 13, 12 pro, 12
            size = 1
            break
        case 852.0: // iphone 14 pro
            size = 1
            break
        case 926.0: // iphone 14 plus, iphone 13 pro max, 12 pro max
            size = 1.05
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch, 11 pro max, 11
            size = 1.05
            break
        case 932.0: // iPhone14 Pro Max
            size = 1.08
            break
        default:
            size = 1
            break
        }
        return size
    }
}
