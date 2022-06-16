//
//  CdListView.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct CdListView: View {
    
    var body: some View {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
    //                if(item == nil) {
                    SnapCarousel().environmentObject(UIStateModel())
                    
                    //else {
    //                Text("아직 기록된 음악이 없어요")
    //                    .font(Font.customTitle2())
    //                    .foregroundColor(.titleGray)
    //                    .padding(.bottom, 12)
    //                    .padding(.top, 260)
    //                Button("음악 기록하러 가기") {
    //                    //go to WriteView
    //                }
    //                Spacer()
    //                Image("ListViewCdPlayer")
                }.ignoresSafeArea()
            }
            .navigationBarTitle("List", displayMode: .inline)
    }
}
