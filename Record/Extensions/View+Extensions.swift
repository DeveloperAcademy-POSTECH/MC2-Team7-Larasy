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

extension View {
    /// Layers the given views behind this ``TextEditor``.
    func textEditorBackground(color: Color, isLighting: Bool) -> some View {
        if #available(iOS 16.0, *) {
            return self
                .scrollContentBackground(.hidden) // <- Hide it
                .background(RecordColor.recordBackgroundWhite.fetchColor(isLighting: isLighting))
                
        } else {
            // Fallback on earlier versions
            return self
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
        }
    }
}
