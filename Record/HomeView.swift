//
//  HomeView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct HomeView: View {
    
    //lamp lighting animation control var
    @State var isLighting : Bool = false
    //cd rotate animation angle var
    @State private var angle = 0.0
    
    var body: some View {
        //Nav View Start
        NavigationView{
            ZStack {
                    Color.background
                    .ignoresSafeArea()
                //Contents Start
                
                    //Logo Start
                    Image("backwindow")
                        .padding(.leading, UIScreen.getWidth(90))
                VStack(alignment: .leading) {
                    
                    Image("Logo")       //Logo Image (RE:CORD)
                        .padding(.top, UIScreen.getHeight(47))
                        .padding(.leading, UIScreen.getWidth(34))
                    
                    //Logo End
                    
                    //CD Rotate ani Start
                    ZStack {
                        VStack {
                            HStack(spacing: 5) {
                                //'CDListView' Navlink Start
                                
                                VStack(spacing: 0) {
                                    Text("내 음악 보러 가기")
                                        .foregroundColor(.titleDarkgray)
                                        .font(Font.customHeadline())
                                        .padding(.top, UIScreen.getHeight(50))
                                    //cdcase img 클릭시 CDListView로 이동하는 Navlink
                                    NavigationLink(destination: CdListView()){
                                        Image("cdcase")     //cdcase Image
                                    }.navigationBarTitle("홈")
                                    Image("shelf")
                                }
                                .frame(
                                    minWidth: 0, maxWidth: .infinity,
                                    alignment: .topLeading
                                )
//                                .padding(.leading, UIScreen.getWidth(-10))
                                
                                ZStack {
                                    ZStack(alignment: .top) {
                                        Image("CdPlayer")
                                        
                                        Image("HomeCD")     //CD Image
                                            .rotationEffect(.degrees(self.angle))
                                            .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                            .onTapGesture {
                                                self.angle += Double.random(in: 3600..<3960)
                                            }
                                        //CD Rotate ani End
                                    }
                                }
                                .padding(.top, UIScreen.getHeight(25))
                                .padding(.trailing, UIScreen.getWidth(50))
                            }
                            Spacer()
                                .frame(maxWidth: .infinity)
                        }
                        
                        
                        //'CDListView' Navlink End
                        //'SearchView' Navlink Start
                        
                        VStack(alignment: .trailing, spacing: UIScreen.getHeight(-5)) {
                            Spacer()
                                .frame(maxWidth: .infinity)
                            HStack(alignment: .bottom, spacing: 45) {
                                ZStack(alignment: .top) {
                                    Image("lampTop")
                                        .blur(radius: isLighting ? 25 : 0)
                                        .animation(.spring(), value: isLighting)
                                    Image("lamp")
                                }.onTapGesture {
                                    isLighting.toggle()
                                }
                                
                                VStack {
                                    Text("음악 기록하기")
                                        .foregroundColor(.titleDarkgray)
                                        .font(Font.customHeadline())
                                    NavigationLink(destination: SearchView()){
                                        Image("note")
                                    }
                                }
                            }
                            Image("desk")
                                .padding(.leading, UIScreen.getWidth(40))
                        }
                        
                    }
                    .ignoresSafeArea()
                    }
                    .frame(
                        minWidth: 0, maxWidth: .infinity,
                        minHeight: 0, maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    //Contents End
                
            }.navigationBarHidden(true)
        }.accentColor(.pointBlue)   //Nav button point color
        //Nav View End
    }
    //View End
}
//HomeView End

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
