//
//  HomeView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct HomeView: View {
    
    //램프 클릭시 라이팅됨
    @State var isLighting : Bool = false
    //씨디 클릭시 돌아감
    @State private var angle = 0.0
    
    var body: some View {
        NavigationView{
            //백그라운드 컬러
            ZStack {
                Color("background")
                    .ignoresSafeArea()
//                if isLighting {
//                    Color("darkbg")
//                        .ignoresSafeArea()
//                } else {
//                    Color("background")
//                        .ignoresSafeArea()
//                }
                //다크모드 스킨
                //백그라운드 창문 이미지
                ZStack (alignment: .leading){
                    Image("HomeBG")
                    //로고 이미지
                    VStack {
                        Image("Logo")
                        
                            .padding(.top,94)
                            .padding(.leading,34)
                        Spacer()
                    }
                    //씨디 돌아가는 애니메이션
                    VStack {
                        Image("HomeCD")
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(self.angle))
                            .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                            .onTapGesture {
                                self.angle += Double.random(in: 3600..<3960)
                            }
                        Spacer()
                    }.padding(.leading,232)
                        .padding(.top,167)
                    //내 음악 보러 가기
                    VStack{
                        Text("내 음악 보러 가기")
                            .foregroundColor(.titleDarkgray)
                            .font(.body)
                            .fontWeight(.bold)
                            .lineSpacing(25)
                            .padding(-15)
                        NavigationLink(destination: ListView()){
                            Image("cdcase")
                        }
                    }
                    .padding(.bottom, 105)
                    .padding(.leading, 30)
                    //내 음악 보러 가기 끝
                    //음악 기록하기
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("음악 기록하기")
                            .foregroundColor(.titleDarkgray)
                            .font(.body)
                            .fontWeight(.bold)
                            .lineSpacing(25)
                            .padding([.top, .trailing], 35.0)
                            .padding(-5)
                        //램프,노트 이미지 배치
                        HStack {
                            ZStack{
                                Image("lampTop")
                                    .blur(radius: isLighting ? 25 : 0)
                                    .animation(.spring(), value: isLighting)
                                    .padding(.bottom,47)
                                Image("lamp")
                                    .padding(43)
                            }.onTapGesture {
                                isLighting.toggle()
                            }
                            VStack {
                                NavigationLink(destination: SearchView()){
                                    Image("note")
                                }
                            }.padding(.bottom,73)
                        }
                    }
                    //음악 기록하기 끝
                }
            }.navigationBarHidden(true)
            //백그라운드 컬러 끝
        }//.accentColor(.blue)
        //네비게이션 뷰 끝
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
