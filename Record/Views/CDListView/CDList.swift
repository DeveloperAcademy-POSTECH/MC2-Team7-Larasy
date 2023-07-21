//
//  CDList.swift
//  Record
//
//  Created by 이지원 on 2023/02/25.
//

import SwiftUI

/**
 사용자가 저장한 모든 CD(이야기)를 캐러셀 형태로 보여주는 뷰 입니다.
 
 - Parameters:
    - items: Content 리스트 (core data에 저장된 데이터)
    - currentIndex: 사용자가 선택한 CD index 번호
 */

struct CDList: View {
    @AppStorage ("isLighting") var isLighting = false
    
    @Binding var items: [Content]
    @Binding var currentIndex: Int
    
    // MARK: Carousel Animaion
    @State private var pointX: CGFloat = 0
    @State private var size: CGSize = .zero
    @State private var isDragging = false

    @GestureState private var offsetState: CGSize = .zero
    
    private let spacing: CGFloat = -UIScreen.getWidth(90)
    private let cdSize: CGFloat = UIScreen.getWidth(200)
    
    private var firstItemPositionX: CGFloat {
        (cdSize * CGFloat(max(0, items.count - 1)) + spacing *  CGFloat(max(0, items.count - 1))) / 2 + size.width / 2
    }
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { proxy in
                
                HStack(spacing: spacing) {
                    
                    ForEach (items.indices, id: \.self) { i in
                        
                        // MARK: - CD
                        ZStack {
                            
                            URLImage(urlString: items[i].albumArt ?? "")
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .shadow(color: RecordColor.recordShadowGray.fetchColor(isLighting: isLighting), radius: 4, x: 0, y: 4)
                            
                            Circle()
                                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                                .foregroundColor(RecordColor.recordBackground.fetchColor(isLighting: isLighting))
                                .overlay(
                                    Circle()
                                        .stroke(RecordColor.recordBackground.fetchColor(isLighting: isLighting), lineWidth: 0.1)
                                        .shadow(color: RecordColor.recordShadowGray.fetchColor(isLighting: isLighting), radius: 2, x: 3, y: 3)
                                )
                        }
                        .frame(width: cdSize, height: cdSize)
                        .scaleEffect(max(1.0 - abs(distance(i)) * 0.25, 0.0001))
                        .zIndex(1.0 - abs(distance(i) * 0.1))
                        .opacity(1.0 - abs(distance(i) * 0.3))
                        .frame { value in
                            let range = cdSize + spacing
                            
                            if isDragging {
                                var ratio: CGFloat {
                                    switch value.origin.x {
                                    case (proxy.size.width / 2 - cdSize / 2)...(proxy.size.width + cdSize / 2 + spacing):
                                        let offset = (proxy.size.width + cdSize / 2 + spacing) - (proxy.size.width / 2) - value.origin.x
                                        return offset / range
                                        
                                    case (spacing / 2)..<(proxy.size.width / 2 - cdSize / 2):
                                        let offset = ((proxy.size.width - cdSize) / 2) - value.origin.x
                                        return 1 - offset / range
                                        
                                    default:
                                        return 0
                                    }
                                }
                                
                                withAnimation {
                                    if 0.5 < ratio {
                                        currentIndex = i
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                self.currentIndex = i
                                pointX = -(CGFloat(currentIndex) * cdSize + (CGFloat(currentIndex) * spacing))
                            }
                        }
                    }
                }
                .position(x: firstItemPositionX + pointX + offsetState.width, y: proxy.size.height / 2)
                .task {
                    size = proxy.size
                }
            }
        }
        .onAppear {
            withAnimation {
                pointX = -(CGFloat(currentIndex) * cdSize + (CGFloat(currentIndex) * spacing))
            }
        }
        .gesture(
            DragGesture()
                .updating($offsetState) { currentState, gestureState, transaction in
                    gestureState = currentState.translation
                }
                .onChanged { value in
                    isDragging = true
                }

                .onEnded { value in

                    isDragging = false
                    pointX += value.translation.width

                    withAnimation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0)) {
                        pointX = -(CGFloat(currentIndex) * cdSize + (CGFloat(currentIndex) * spacing))
                    }

                    let haptic = UIImpactFeedbackGenerator(style: .soft)
                    haptic.impactOccurred()
                }
    )
        .frame(height: cdSize)
        
    }
    
    private func distance(_ index: Int) -> Double {
        return Double(currentIndex - index)
    }
}
