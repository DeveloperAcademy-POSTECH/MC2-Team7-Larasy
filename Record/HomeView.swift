//
//  HomeView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct HomeView: View {
    
    @State var isLighting : Bool = false
    @State private var angle = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                Image("backwindow")
                    .padding(.leading, UIScreen.getWidth(90))
                
                VStack(alignment: .leading) {
                    
                    Image("Logo")
                        .padding(.top, UIScreen.getHeight(47))
                        .padding(.leading, UIScreen.getWidth(34))
                    
                    ZStack {
                        VStack {
                            HStack(spacing: 5) {
                                
                                // MARK: link to CDListView
                                VStack(spacing: 0) {
                                    Text("내 음악 보러 가기")
                                        .foregroundColor(.titleDarkgray)
                                        .font(Font.customHeadline())
                                        .padding(.top, UIScreen.getHeight(50))
                                    
                                    NavigationLink(destination: CdListView()) {
                                        Image("album")
                                    }
                                    .navigationBarTitle("홈")
                                    
                                    Image("shelf")
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                
                                
                                // MARK: CD Player
                                ZStack(alignment: .top) {
                                    Image("CdPlayer")
                                    
                                    Image("HomeCD")
                                        .rotationEffect(.degrees(angle))
                                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                        .onTapGesture { angle += Double.random(in: 3600 ..< 3960) }
                                }
                                .padding(.top, UIScreen.getHeight(25))
                                .padding(.trailing, UIScreen.getWidth(50))
                            }
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                        }
                        
                        
                        VStack(alignment: .trailing, spacing: UIScreen.getHeight(-5)) {
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                            
                            Image("polaroid")
                                .padding(.bottom, UIScreen.getHeight(120))

                            // MARK: Lamp
                            HStack(alignment: .bottom, spacing: 45) {
                                ZStack(alignment: .top) {
                                    Image("lampTop")
                                        .blur(radius: isLighting ? 25 : 0)
                                        .animation(.spring(), value: isLighting)
                                    
                                    Image("lamp")
                                }
                                .onTapGesture {
                                    isLighting.toggle()
                                }
                                
                                // MARK: Link to SearchView
                                VStack(spacing: 0) {
                                    Text("음악 기록하기")
                                        .foregroundColor(.titleDarkgray)
                                        .font(Font.customHeadline())
                                    
                                    NavigationLink(destination: SearchView()) {
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
                .frame(maxHeight: .infinity, alignment: .topLeading)
                
            }
            .navigationBarHidden(true)
        }
        .accentColor(.pointBlue)
    }
}


// MARK: PreviewProvider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
