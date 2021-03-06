//
//  CdListView.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct CdListView: View {
    
    //coredata 관련 변수
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Content>
    
    @State var selection: Int? = nil
    
    var body: some View {
        
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                VStack {
                    //TODO: nil일때 보여주는 화면 작성
                    
                    if items.count != 0 {
                        SnapCarousel(selection: $selection)
                            .environmentObject(UIStateModel())
                    } else {
                        VStack {
                            Text("아직 기록된 음악이 없어요")
                                .font(Font.customTitle2())
                                .foregroundColor(.titleGray)
                                .padding(.bottom, 12)
                                .padding(.top, 260)
                            
                            NavigationLink(destination: SearchView()) {
                                Text("음악 기록하러 가기")
                            }//.isDetailLink(false)
                                //go to WriteView
                                Spacer()
                                Image("ListViewCdPlayer")
                            
                        }
                    }
                }.ignoresSafeArea()
                    
            }
            .navigationBarTitle("List", displayMode: .inline)
           
    }
}
