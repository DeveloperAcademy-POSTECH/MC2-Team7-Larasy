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
                ZStack (alignment: .leading){
                    Image("HomeBG")     //Background fix Image (창문 및 가구)
                    //Logo Start
                    VStack {
                        Image("Logo")       //Logo Image (RE:CORD)
                            .padding(.top,94)
                            .padding(.leading,34)
                        Spacer()
                    }
                    //Logo End
                    //CD Rotate ani Start
                    VStack {
                        Image("HomeCD")     //CD Image
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(self.angle))
                            .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                            .onTapGesture {
                                self.angle += Double.random(in: 3600..<3960)
                            }
                        Spacer()
                    }.padding(.leading,232)
                        .padding(.top,167)
                    //CD Rotate ani End
                    //'CDListView' Navlink Start
                    VStack{
                        Text("내 음악 보러 가기")
                            .foregroundColor(.titleDarkgray)
                            .font(Font.customHeadline())
                            .padding(-15)
                        //cdcase img 클릭시 CDListView로 이동하는 Navlink
                        NavigationLink(destination: ListView()){
                            Image("cdcase")     //cdcase Image
                        }
                    }
                    .padding(.bottom, 105)
                    .padding(.leading, 30)
                    //'CDListView' Navlink End
                    //'SearchView' Navlink Start
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("음악 기록하기")
                            .foregroundColor(.titleDarkgray)
                            .font(Font.customHeadline())
                            .padding([.top, .trailing], 35.0)
                            .padding(-5)
                        //lamp & note Image 배치 Start
                        HStack {
                            //lamp lighting ani Start
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
                            //lamp lighting ani End
                            //note Image 클릭시 SearchView로 이동하는 Navlink
                            VStack {
                                NavigationLink(destination: SearchView()){
                                    Image("note")
                                }
                            }.padding(.bottom,73)
                        }
                        //lamp & note Image 배치 End
                    }
                }
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
