//
//  OnboardingLastPageView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/16.
//

import SwiftUI

//홈 뷰로 가기위한 마지막 온보딩 뷰
struct FourthPage: View {
    
    //이미지 fadein 애니메이션
    @State var isShown = false
    //앱최초 실행 바인딩
    @Binding var isFirstLaunching: Bool

    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                Color.background
                    .ignoresSafeArea()
                // MARK: Image, Animation
                VStack {
                    if isShown {
                        Image("onboarding4")
                        //                        .frame(width: UIScreen.getWidth(450), height: UIScreen.getHeight(362))
                            .transition(.opacity)
                    }
                }
                .frame(maxHeight: UIScreen.getHeight(362))
                .animation(Animation.easeInOut(duration: 1).delay(0.3),value: isShown)
                .onAppear() {
                    self.isShown = true
                }
                
                // MARK: Button
                VStack {
                    Spacer()
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        isFirstLaunching.toggle()
                    }) {
                        Text("음악 기록 시작하기")
                            .foregroundColor(.white)
                            .font(Font.customHeadline())
                            .frame(width: 200, height: 60)
                            .background(Color.pointBlue)
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 5, x: 0, y: 3)
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 30)
                }
                
                // MARK: Text
                VStack(alignment: .leading) {
                    Text("음악기록가가 되신것을\n환영합니다!")
                        .foregroundColor(.titleBlack)
                        .font(Font.customTitle2())
                        .lineSpacing(5)
                        .frame(width:330, alignment: .leading)
                        .padding(.leading, UIScreen.getWidth(30))
                        .padding(.top, UIScreen.getHeight(100))
                    
                    Spacer()
                        .frame(maxWidth: .infinity)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct FourthPage_Previews: PreviewProvider {
    static var previews: some View {
        FourthPage(isFirstLaunching: .constant(false))
    }
}


//https://stackoverflow.com/questions/65240310/fade-in-a-control-in-when-a-view-is-loaded-and-not-inserted-after-a-state-chang
