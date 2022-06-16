//
//  RecordResultView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//

import SwiftUI

struct RecordResultView: View {
    @State var isSelected : Bool = false
    
    var body: some View {
        NavigationView {
            RecordDetailView()
                .navigationBarItems(leading:
                                        NavigationLink(destination: SearchView(), // TODO: ListView destination예정
                                                       label: {
                    Image(systemName: "chevron.backward")
                    Text("List")
                }).foregroundColor(.pointBlue),
                                    trailing: Menu(content: {
                    Button(action: {}) { // TODO: antion내에 편집 기능 예정
                        Label("수정", systemImage: "pencil")
                    }
                    Button(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let image = body.screenshot()
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)}
                    }) { // TODO: Soi코딩 중인 스크린샷 기능 예정
                        Label("이미지로 저장", systemImage: "square.and.arrow.down")
                }
                    Button(role: .destructive, action: {}) { // TODO: action에 삭제 Alert띄우기 및 삭제 기능 예정
                        Label("삭제", systemImage: "trash")
                    }
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.pointBlue)
                }) // Menu 출력
                ) // NavigationVarItem 설정
        } // Navigation View 출력
    } // View End
} // RecordResultView End

struct RecordResultView_Previews: PreviewProvider {
    static var previews: some View {
        RecordResultView()
    }
}
