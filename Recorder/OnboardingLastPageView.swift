//
//  OnboardingLastPageView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/16.
//

import SwiftUI

//초기 시작화면을 결정하는 뷰
struct OnboardingStartView: View{
    
    @State var StartButton: Bool = false
    //스타트 버튼을 누르기 전까지는 else. 즉 온보딩 뷰가 보임
    var body: some View {
        if StartButton {
            HomeView()
        } else {
            OnboardingView(StartButton: $StartButton)
        }
    }
}

//홈 뷰로 가기위한 마지막 온보딩 뷰
struct OnboardingLastPageView: View {
    
    //이미지 fadein 애니메이션
    @State var isShown = false
    //스타트 버튼 바인딩
    @Binding var StartButton: Bool
    
    var body: some View {
        ZStack {
            Text("음악기록가가 되신것을\n환영합니다!")
                .foregroundColor(.titleBlack)
                .font(Font.customTitle2())
                .frame(width:330, alignment: .leading)
                .padding(.bottom,500)
            //TODO: 행간 수정
            //Image Fadein Animation Start
            VStack {
                if isShown {
                    Image("Page4")
                        .transition(.opacity)
                }
            }
            .animation(Animation.easeInOut(duration: 1).delay(0.3),value: isShown)
            .onAppear() {
                self.isShown = true
            }
            //Image Fadein Animation End
            //Button Start
            Button(action: {
                StartButton.toggle()
            }) {
                Text("음악 기록 시작하기")
                    .foregroundColor(.white)
                    .font(Font.customHeadline())
                    .frame(width: 200, height: 60)
                    .background(Color.pointBlue)
                    .cornerRadius(30)
                    .shadow(color: .gray, radius: 10, x: 0, y: 3)
            }
            .padding(.top,650)
            //Button End
        }
        //Zstack End
    }
    //View End
}

struct OnboardingLastPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingLastPageView(StartButton: .constant(false))
    }
}


//https://stackoverflow.com/questions/65240310/fade-in-a-control-in-when-a-view-is-loaded-and-not-inserted-after-a-state-chang
