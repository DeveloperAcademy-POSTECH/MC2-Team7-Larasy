//
//  HomeView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct HomeView: View {
    
    @State var isLighting : Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                ZStack (alignment: .leading){
                    Image("homeBG")
                    VStack{
                        Text("내 음악 보러 가기")
                            .font(.body)
                            .fontWeight(.bold)
                            .lineSpacing(25)
                        NavigationLink(destination: ListView()){
                            Image("cdcase")
                        }
                    }
                    .padding(.bottom, 130)
                    .padding(.leading, 30)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("음악 기록하기")
                        //.foregroundColor(.gray)
                            .font(.body)
                            .fontWeight(.bold)
                            .lineSpacing(25)
                            .padding([.top, .trailing], 30.0)
                        HStack {
                            ZStack{
                                Image("lampTop")
                                    .blur(radius: isLighting ? 25 : 0)
                                    .padding(.bottom,50)
                                Image("lamp")
                                    .padding(43)
                            }.onTapGesture {
                                isLighting.toggle()
                            }
                            VStack {
                                NavigationLink(destination: SearchView()){
                                    Image("note")
                                }
                            }.padding(.bottom,74)
                        }
                    }
                }
            }.navigationBarHidden(true)
        }//.accentColor(.blue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
