//
//  OnboardingLastPageView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/16.
//

import SwiftUI

//홈 뷰로 가기위한 마지막 온보딩 뷰
struct OnboardingLastPageView: View {
    
    //이미지 fadein 애니메이션
    @State var isShown = false
    //앱 최초 실행 바인딩
    @Binding var isFriestLaunching: Bool

    
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
                isFriestLaunching.toggle()
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
        OnboardingLastPageView(isFriestLaunching: .constant(false))
    }
}


//https://stackoverflow.com/questions/65240310/fade-in-a-control-in-when-a-view-is-loaded-and-not-inserted-after-a-state-chang
