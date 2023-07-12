//
//  HomeView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage ("isLighting") var isLighting = false
    @State private var angle = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                RecordColor.recordBackground.fetchColor(isLighting: isLighting)
                    .ignoresSafeArea()
                
                Image(RecordImage.backwindow.fetchRecordImage(isLighting: isLighting))
                    .padding(.leading, UIScreen.getWidth(90))
                
                Image(RecordImage.moon.fetchRecordImage(isLighting: isLighting))
                    .padding(.bottom, UIScreen.getHeight(90))
                
                VStack(alignment: .leading) {
                    
                    Image("Logo")
                        .padding(.top, UIScreen.getHeight(47))
                        .padding(.leading, UIScreen.getWidth(50))
                    
                    ZStack {
                        VStack {
                            HStack(spacing: 5) {
                                
                                // MARK: link to CDListView
                                
                                VStack(spacing: 0) {
                                    Text("내 음악 보러 가기")
                                        .foregroundColor(.titleDarkgray)
                                        .font(Font.customHeadline())
                                        .padding(.top, UIScreen.getHeight(90))
                                        .padding(.bottom, UIScreen.getHeight(6))
                                    
                                    NavigationLink(destination: CDListView()) {
                                        Image(RecordImage.album.fetchRecordImage(isLighting: isLighting))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.getWidth(130))
                                    }
                                    .navigationBarTitle("홈")
                                    
                                    Image(RecordImage.shelf.fetchRecordImage(isLighting: isLighting))
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                
                                
                                // MARK: CD Player
                                ZStack(alignment: .top) {
                                    
                                    Image(RecordImage.cdPlayer.fetchRecordImage(isLighting: isLighting))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.getWidth(144))
                                    
                                    Image("HomeCD")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.getWidth(130), height: UIScreen.getWidth(130))
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
                            
                            Image(RecordImage.polaroid.fetchRecordImage(isLighting: isLighting))
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.getWidth(60), height: UIScreen.getHeight(80))
                                .padding(.bottom, UIScreen.getHeight(80))
                            
                            // MARK: Lamp
                            HStack(alignment: .bottom, spacing: 45) {
                                ZStack(alignment: .top) {
                                    Image("lampTop")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(30))
                                        .blur(radius: isLighting ? 25 : 0)
                                        .animation(.spring(), value: isLighting)
                                    
                                    Image("lamp")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(83))
                                }
                                .onTapGesture {
                                    isLighting.toggle()
                                }
                                
                                
                                // MARK: Link to SearchView
                                
                                VStack(spacing: 0) {
                                    Text("음악 기록하기")
                                        .foregroundColor(.titleDarkgray)
                                        .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                                        .font(Font.customHeadline())
                                        .padding(.bottom, UIScreen.getHeight(6))
                                    
                                    VStack(spacing: 0) {
                                        NavigationLink(destination: SearchView(isAccessFirst: true)) {
                                            Image(isLighting ? "note_dark" : "note")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.getWidth(170))
                                        }
                                    }
                                    
                                }
                            }
                            
                            Image(RecordImage.desk.fetchRecordImage(isLighting: isLighting))
                                .padding(.leading)
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
