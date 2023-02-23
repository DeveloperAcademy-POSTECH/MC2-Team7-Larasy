//
//  MarqueeTextView.swift
//  Record
//
//  Created by 전지민 on 2023/02/21.
//

import SwiftUI

struct MarqueeTextView: View {
    
    @State var text: String
    var font: UIFont
    
    @State var storedSize: CGSize = .zero
    @State var offset: CGFloat = 0
    
    var animationSpeed = 0.02
    var delayTime = 0.5
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        if textSize().width < UIScreen.getWidth(340) {
            Text(text)
                .font(Font(font))
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(text)
                    .font(Font(font))
                    .offset(x: offset)
                    .padding(.horizontal, 15)
            }
            .overlay(content: {
                HStack {
                    let color = Color.background
                    
                    LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5), color.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                        .frame(width: 20)
                    
                    Spacer()
                    
                    LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5), color.opacity(0.3)].reversed(), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 20)
                }
            })
            .disabled(true)
            .onAppear() {
                
                let baseText = text
                
                (1...15).forEach { _ in
                    text.append(" ")
                }
                storedSize = textSize()
                text.append(baseText)
                
                let timing = animationSpeed * storedSize.width
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear(duration: timing)) {
                        offset = -storedSize.width
                    }
                }
            }
            .onReceive(Timer.publish(every: ((animationSpeed * storedSize.width) + delayTime), on: .main, in: .default).autoconnect()) { _ in
                offset = 0
                withAnimation(.linear(duration: animationSpeed * storedSize.width)) {
                    offset = -storedSize.width
                }
            }
        }
    }
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size
    }
}
