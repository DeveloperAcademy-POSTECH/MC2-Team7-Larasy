//
//  CdListView.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct CDListView: View {
    
    @State private var items = PersistenceController.shared.fetchContent()
    @State private var currentIndex = 0
    
    var body: some View {
        
        ZStack {
            Color("background")
                
            VStack {
                if items.isEmpty {
                    
                    EmptyCDListView()
                    
                } else {
                    
                    VStack(spacing: 0) {
                        
                        ForEach (items.indices, id: \.self) { i in
                            if i == currentIndex {
                                MusicInformation(item: $items[i])
                            }
                        }
                        CDList(items: $items, currentIndex: $currentIndex)
                        CDPlayer(item: $items[currentIndex])
                    }
                }
            }
        }
        .navigationBarTitle("리스트", displayMode: .inline)
        .ignoresSafeArea()
        .onAppear {
            items = PersistenceController.shared.fetchContent()
            currentIndex = min(currentIndex, items.count - 1)
        }
    }
}
