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
    @AppStorage("_isFirstLaunching") var isFriestLaunching: Bool = true
    @State var StartButton: Bool = false
    
    //스타트 버튼을 누르기 전까지는 else. 즉 온보딩 뷰가 보임
    var body: some View {
        if !isFriestLaunching {
            HomeView()
        } else {
            OnboardingView(isFriestLaunching: $isFriestLaunching)
        }
    }
}

//온보딩 뷰
struct OnboardingView: View {
    
    @Binding var isFriestLaunching: Bool
    
    let title : [String] = ["나의 이야기로\n간직하고 싶은 음악이 있나요?","음악을 사진과 함께\n짧은 이야기로 기록하고,\n기억하고 싶은 가사를 입력하세요.","나만의 방에서 \n음악을 플레이어에 재생시키고 \n기록을 다시 감상하세요."]
    let backgroundImage : [String] = ["Page1","Page2","Page3"]
    
    var body: some View {
        //TODO: 온보딩 최초 실행시만 나타내기
        ZStack {
            Color.background
                .ignoresSafeArea(.all)
            //OnboardingPage Tab view Start
            TabView{
                ForEach(title.indices, id: \.self) { page in
                    ZStack {
                        Image(backgroundImage[page])
                        Text(title[page])
                            .foregroundColor(.titleBlack)
                            .font(Font.customTitle2())
                            .frame(width:330, alignment: .leading)
                            .padding(.bottom,500)
                        //TODO: 행간 수정
                    }
                }
                OnboardingLastPageView(isFriestLaunching: $isFriestLaunching)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))//TODO: 페이지 인덱스 커스텀
            //OnboardingPage Tab View End
        }.ignoresSafeArea()
        //Zstack End
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isFriestLaunching: .constant(false))
    }
}
