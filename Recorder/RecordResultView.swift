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
            RecordDetailView()// 본문뷰 노출예정
                .navigationBarItems(leading:
                                        NavigationLink(destination: SearchView(),
                                                       label: {
                   Image(systemName: "chevron.backward")
                    Text("List")
                }
                )
                                            .foregroundColor(.pointBlue)
                ,
                                        trailing:
                                        Menu(content: {
                    Button(action: {}) {
                        Label("수정", systemImage: "pencil")
                    }
                    Button(action: {}) {
                        Label("이미지로 저장", systemImage: "square.and.arrow.down")
                    }
                    Button(role: .destructive, action: {}) {
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
