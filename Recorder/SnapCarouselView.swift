//
//  Carousel.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/16.
//

import SwiftUI

struct SnapCarousel: View {

    @State private var angle = 0.0 // cd ratation angle 초기값
    @EnvironmentObject var UIState: UIStateModel
    @State var showCd: Bool = false // cd player에 cd 나타나기
    @State var showDetailView = false // detailView 나타나기
    @State var value: Int = 0
    @State var selectedCd: Int = 0
    @State var currentCd: Int = 0
    
    var body: some View {
        let spacing: CGFloat = -10
        let widthOfHiddenCds: CGFloat = 100
        let cdHeight: CGFloat = 300
        
        // 기록물 id, 곡제목, 가수명, 앨범커버 배열 예시
        var cds = [
            Cd(id: 0, musicTitle: "노래제목1", singer: "가수명1", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/500x500bb.jpg"),
            Cd(id: 1, musicTitle: "노래제목2", singer: "가수명2", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/17/ff/63/17ff63de-3aba-0f2d-63e7-50d66f900ebb/21UMGIM43558.rgb.jpg/500x500bb.jpg"),
            Cd(id: 2, musicTitle: "노래제목3", singer: "가수명3", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/500x500bb.jpg"),
            Cd(id: 3, musicTitle: "노래제목4", singer: "가수명4", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/17/ff/63/17ff63de-3aba-0f2d-63e7-50d66f900ebb/21UMGIM43558.rgb.jpg/500x500bb.jpg"),
            Cd(id: 4, musicTitle: "노래제목5", singer: "가수명5", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/500x500bb.jpg")
        ]
        
        // https://gist.github.com/xtabbas/97b44b854e1315384b7d1d5ccce20623.js 의 샘플코드를 참고했습니다.
        return Canvas {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                // Carousel 슬라이더 기능
                // ForEach로 items마다 Item() 뷰를 각각 불러옴
                VStack {
                    Carousel(
                        numberOfItems: CGFloat(cds.count),
                        spacing: spacing,
                        widthOfHiddenCds: widthOfHiddenCds
                    ) {
                        ForEach(cds, id: \.self.id) { content in
                            Item(
                                _id: Int(content.id),
                                spacing: spacing,
                                widthOfHiddenCds: widthOfHiddenCds,
                                cdHeight: cdHeight
                            ) {
                                // 가운데 cd만 글이 보이게 함
                                VStack {
                                    if (content.id == UIState.activeCard) {
                                        Text("\(content.musicTitle)")
                                            .foregroundColor(Color.titleBlack)
                                            .font(Font.customTitle3())
                                            .padding(.bottom, 5)
                                        Text("\(content.singer)")
                                            .foregroundColor(Color.titleDarkgray)
                                            .font(Font.customBody2())
                                            .padding(.bottom, 30)
                                    } else {
                                        Spacer()
                                            .frame(height: 70)
                                    }
                                    // cd자체가 버튼으로 기능해 선택된 id값 저장
                                    Button(action: {
                                        if self.showCd {
                                            self.showCd = false
                                            self.selectedCd = self.currentCd
                                            
                                        } else {
                                            self.showCd = true
                                            self.selectedCd = content.id
                                            self.currentCd = self.selectedCd
                                        }
                                        
                                    }) {
                                        ZStack {
                                            URLImage(urlString: content.image)
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                                            Circle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.background)
                                                .overlay(
                                                    Circle()
                                                        .stroke(.background, lineWidth: 0.1)
                                                        .shadow(color: .titleDarkgray, radius: 2, x: 3, y: 3)
                                                )
                                        }
                                    } // 버튼
                                    .disabled(UIState.activeCard != content.id)
                                    .onChange(of: UIState.activeCard) { newCd in
                                        if newCd != selectedCd {
                                            self.showCd = false
                                        }
                                    }
                                } // V 스택
                            }
                            .transition(AnyTransition.slide)
                            .animation(.spring())
                        } // ForEach
                    }
                    .padding(.top, 140)
                    
                    Spacer()
                    // CdPlayer
                    ZStack {
                        Image("ListViewCdPlayer")
                        
                        // cd 클릭시, cdPlayer에 cd 나타남
                        VStack {
                            if showCd == true {
                                NavigationLink(destination: RecordDetailView(), isActive: $showDetailView) {
                                    URLImage(urlString: cds[selectedCd].image)
                                        .clipShape(Circle())
                                        .frame(width: 110, height: 110)
                                        .rotationEffect(.degrees(self.angle))
                                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                        .onTapGesture {
                                            self.angle += Double.random(in: 1000..<1980)
                                            timeCount()
                                        }
                                }
                            } else {
                                NavigationLink(destination: RecordDetailView(), isActive: $showDetailView) {
                                    URLImage(urlString: cds[selectedCd].image)
                                        .clipShape(Circle())
                                        .frame(width: 110, height: 110)
                                        .rotationEffect(.degrees(self.angle))
                                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                        .onTapGesture {
                                            self.angle += Double.random(in: 1000..<1980)
                                            timeCount()
                                        }
                                }
                            } // else문
                        } // V스택
                        .padding(.bottom, 180)
                        .padding(.leading, 2) // CdPlayer를 그림자 포함해서 뽑아서 전체 CdPlayer와 정렬 맞추기 위함
                        
                        // cdPlayer 가운데 원
                        VStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.titleLightgray)
                                    .frame(width: 30 , height: 30)
                                Circle()
                                    .foregroundColor(.titleDarkgray)
                                    .frame(width: 15 , height: 15)
                                    .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                                Circle()
                                    .foregroundColor(.background)
                                    .frame(width: 3 , height: 3)
                            } // Z스택
                        } // V스택
                        .padding(.bottom, 180)
                        .padding(.leading, 4)
                    } // Z스택
                } // V스택
                .ignoresSafeArea()
            } // Z스택
        } // Canvas
        .navigationBarTitle("List", displayMode: .inline)
        
        
    } // 바디 뷰
    
    // 네비게이션 링크로 이동되는 RecordResultView를 딜레이시키고 애니메이션을 보여주기 위한 타임 카운터
    func timeCount() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.value += 1
            
            if self.value == 1 {
                self.showDetailView = true
                self.value = 0
                
                return
            }
        }
    } // func
    
} // SnapCarousel 뷰
