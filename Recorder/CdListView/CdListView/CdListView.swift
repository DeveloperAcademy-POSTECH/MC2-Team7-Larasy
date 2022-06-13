//
//  CdListView.swift
//  CdListView
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct CdListView: View {
    var body: some View {
        VStack {
            //if(item == nil) {
            //SnapCarousel().environmentObject(UIStateModel())
            
            //else {
            Text("아직 기록된 음악이 없어요")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.bottom, 12)
                .padding(.top, 260)
            Button("음악 기록하러 가기") {
                //go to AddView
            }
            Spacer()
            Image("CdPlayer")
        }.ignoresSafeArea()
    }
}

struct CdListView_Previews: PreviewProvider {
    static var previews: some View {
        CdListView().environmentObject(UIStateModel())
    }
}
