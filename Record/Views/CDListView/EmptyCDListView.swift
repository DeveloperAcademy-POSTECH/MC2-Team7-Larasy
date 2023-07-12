//
//  EmptyCDListView.swift
//  Record
//
//  Created by 이지원 on 2023/02/22.
//

import SwiftUI

/**
 data가 비어있을 때, 출력되는 뷰 입니다.
 */
struct EmptyCDListView: View {
    @AppStorage ("isLighting") var isLighting = false
    
    var body: some View {
        VStack {
            
            Text("아직 기록된 음악이 없어요")
                .font(Font.customTitle2())
                .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                .padding(.bottom, UIScreen.getHeight(12))
                .padding(.top, UIScreen.getHeight(260))
            
            NavigationLink(destination: SearchView(isAccessFirst: true)) {
                Text("음악 기록하러 가기")
            }
            
            Spacer()
            
            Image(RecordImage.listViewCdPlayer.fetchRecordImage(isLighting: isLighting))
        }
    }
}

struct EmptyCDListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCDListView()
    }
}
