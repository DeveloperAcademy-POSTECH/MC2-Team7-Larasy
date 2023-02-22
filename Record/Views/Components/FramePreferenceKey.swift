//
//  FramePreferenceKey.swift
//  Record
//
//  Created by 이지원 on 2023/02/23.
//

import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
