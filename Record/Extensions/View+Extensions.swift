//
//  View+Extensions.swift
//  Record
//
//  Created by 이지원 on 2022/10/05.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


extension View {
    
    func frame(perform: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: $0.frame(in: .global))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self) { value in
            DispatchQueue.main.async { perform(value) }
        }
    }
}
