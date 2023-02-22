//
//  CdListView.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct CdListView: View {
    
    @State private var items = PersistenceController.shared.fetchContent()
    
    // MARK: Carousel Animaion
    @State private var pointX: CGFloat = 0
    @State private var size: CGSize = .zero
    @State private var isDragging = false
    @State private var currentIndex = 0
    
    @GestureState private var offsetState: CGSize = .zero
    
    private let spacing: CGFloat = -UIScreen.getWidth(90)
    private let cdSize: CGFloat = UIScreen.getWidth(200)
    
    private var firstItemPositionX: CGFloat {
        (cdSize * CGFloat(max(0, items.count - 1)) + spacing *  CGFloat(max(0, items.count - 1))) / 2 + size.width / 2
    }
    
    // MARK: Navigation
    @State private var angle = 0.0
    @State private var showDetailView = false
    
    
    var body: some View {
        
        ZStack {
            Color("background")
                
            
            VStack {
                if items.isEmpty {
                    EmptyCDListView()
                } else {
                    VStack(spacing: 0) {
                        musicInformation
                        cdList
                        cdPlayer
                    }
                }
            }
        }
        .navigationBarTitle("리스트", displayMode: .inline)
        .ignoresSafeArea()
        .onAppear {
            items = PersistenceController.shared.fetchContent()
        }
    }
    
    
    // MARK: - 노래 제목과 가수 이름
    var musicInformation: some View {
        VStack {
            Text(items[currentIndex].title ?? "")
                .foregroundColor(Color.titleBlack)
                .font(Font.customTitle3())
                .padding(.bottom, UIScreen.getHeight(2))
                .frame(minWidth: UIScreen.getWidth(340))
            
            
            Text(items[currentIndex].artist ?? "")
                .foregroundColor(Color.titleDarkgray)
                .font(Font.customBody2())
                .padding(.bottom, UIScreen.getHeight(20))
                .frame(minWidth: UIScreen.getWidth(340))
        }
        .padding(.top, UIScreen.getHeight(140))
        .padding(.bottom, UIScreen.getHeight(30))
    }
    
    // MARK: - CD List
    var cdList: some View {
        ZStack {
            GeometryReader { proxy in
                HStack(spacing: spacing) {
                    ForEach (0 ..< items.count, id: \.self) { i in
                        ZStack {
                            URLImage(urlString: items[i].albumArt ?? "")
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                            
                            Circle()
                                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                                .foregroundColor(.background)
                                .overlay(
                                    Circle()
                                        .stroke(.background, lineWidth: 0.1)
                                        .shadow(color: .titleDarkgray, radius: 2, x: 3, y: 3)
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
                }
    )
        .frame(height: cdSize)

    }
    
    var cdPlayer: some View {
        VStack {
            Text("CD를 선택하고 플레이어를 재생해보세요")
                .foregroundColor(.titleGray)
                .font(.customBody2())
                .frame(width: UIScreen.getWidth(300))
                .padding(.bottom, UIScreen.getHeight(-20))
                .padding(.top, UIScreen.getHeight(45))
            
            
            ZStack {
                Image("ListViewCdPlayer")
                    .offset(y: 30)
                
                NavigationLink(destination: RecordDetailView(item: $items[currentIndex]), isActive: $showDetailView) {
                    URLImage(urlString: items[currentIndex].albumArt ?? "")
                        .clipShape(Circle())
                        .frame(width: UIScreen.getWidth(110), height: UIScreen.getHeight(110))
                        .rotationEffect(.degrees(self.angle))
                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                        .onTapGesture {
                            self.angle += Double.random(in: 1000..<1980)
                            timeCount()
                        }
                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                        .padding(.bottom, 120)
                        .padding(.leading, 2) // CdPlayer를 그림자 포함해서 뽑아서 전체 CdPlayer와 정렬 맞추기 위함
                }
                
                ZStack {
                    Circle()
                        .foregroundColor(.titleLightgray)
                        .frame(width: UIScreen.getWidth(30) , height: UIScreen.getHeight(30))
                    Circle()
                        .foregroundColor(.titleDarkgray)
                        .frame(width: UIScreen.getWidth(15) , height: UIScreen.getHeight(15))
                        .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                    Circle()
                        .foregroundColor(.background)
                        .frame(width: UIScreen.getWidth(3) , height: UIScreen.getHeight(3))
                }
                .padding(.bottom, 120)
                .padding(.leading, 4)
            }
        }
    }
    
    private func distance(_ index: Int) -> Double {
        return Double(currentIndex - index)
    }
    
    private func timeCount() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.showDetailView = true
        }
    }
    
}
