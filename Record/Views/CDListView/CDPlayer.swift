//
//  CdPlayer.swift
//  Record
//
//  Created by 이지원 on 2023/02/25.
//

import SwiftUI

/**
 화면 하단 Detail view로 이동할 수 있는 CD Player 및 CD를 보여주는 뷰입니다.
 
 - parameters:
    - item: 사용자가 선택한 Content형 데이터를 넣어주세요.
 */


struct CDPlayer: View {
    
    @Binding var item: Content
    
    @State private var angle = 0.0
    @State private var showDetailView = false
    
    @AppStorage ("isLighting") var isLighting = false
    
    var body: some View {
        
        VStack {
            
            Text("CD를 선택하고 플레이어를 재생해보세요".localized)
                .foregroundColor(.titleGray)
                .font(.customBody2())
                .frame(width: UIScreen.getWidth(300))
                .padding(.bottom, UIScreen.getHeight(-20))
                .padding(.top, UIScreen.getHeight(45))
            
            // MARK: - CD Player, 네비게이션 링크
            ZStack {
                
                Image(RecordImage.listViewCdPlayer.fetchRecordImage(isLighting: isLighting))
                    .offset(y: 30)
                
                NavigationLink(destination: RecordDetailView(item: $item), isActive: $showDetailView) {
                    URLImage(urlString: item.albumArt ?? "")
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
                        .foregroundColor(RecordColor.recordDarkCompColor2.fetchColor(isLighting: isLighting))
                        .frame(width: UIScreen.getWidth(30) , height: UIScreen.getHeight(30))
                    Circle()
                        .foregroundColor(RecordColor.recordDarkCompColor.fetchColor(isLighting: isLighting))
                        .frame(width: UIScreen.getWidth(15) , height: UIScreen.getHeight(15))
                        .shadow(color: RecordColor.recordShadowGray.fetchColor(isLighting: isLighting), radius: 4, x: 0, y: 4)
                    Circle()
                        .foregroundColor(RecordColor.recordBackground.fetchColor(isLighting: isLighting))
                        .frame(width: UIScreen.getWidth(3) , height: UIScreen.getHeight(3))
                }
                .padding(.bottom, 120)
                .padding(.leading, 4)
            }
        }
    }
    
    private func timeCount() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.showDetailView = true
        }
    }
}
