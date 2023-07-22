//
//  OnboardingView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/16.
//

import SwiftUI

//초기 시작화면을 결정하는 뷰
struct OnboardingStartView: View{
    
    //최초 실행을 관리하는 앱스토리지
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    //스타트 버튼을 누르기 전까지는 else. 즉 온보딩 뷰가 보임
    @State var StartButton: Bool = false
    var body: some View {
        if !isFirstLaunching {
            HomeView()
        } else {
            OnboardingView(isFirstLaunching: $isFirstLaunching)
        }
    }
}

//온보딩 뷰
struct OnboardingView: View {
    
    @Binding var isFirstLaunching: Bool
    
    //페이징 수를 결정하는 배열과 변수
    @State var selected = 0
    var pageIndex: [Int] = [0, 1, 2, 3]
    
    let title: [String] = ["온보딩1".localized, "온보딩2".localized, "온보딩3".localized]
    let backgroundImage: [String] = ["Page1","Page2","Page3"]
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                Color.background
                    .ignoresSafeArea(.all)
                
                //OnboardingPage Tab view Start
                TabView(selection: $selected){
                    FirstPage().tag(0)
                    SecondPage().tag(1)
                    ThirdPage().tag(2)
                    FourthPage(isFirstLaunching: $isFirstLaunching).tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                
                // Tab View Indicator
                VStack {
                    HStack(spacing: 15) {
                        ForEach(0 ..< 4) {index in
                            Capsule()
                                .foregroundColor(selected == index ? Color.pointYellow : Color.titleLightgray)
                                .frame(width: selected == index ? 7 : 7, height: 7)
                        }
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 15)
                    Spacer()
                        .frame(maxWidth: .infinity)
                }
            }.ignoresSafeArea()
        }
    }
}

//https://youtu.be/uo8gj7RT3H8 속 예제를 참고함


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isFirstLaunching: .constant(false))
    }
}
