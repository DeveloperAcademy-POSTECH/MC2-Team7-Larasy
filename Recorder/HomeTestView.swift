//
//  HomeView.swift
//  Recorder
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct HomeTestView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: CdListView()) {
                Text("CD LIST")
            }.navigationBarTitle("Home")
        }
    }
}

//struct HomeTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTestView()
//    }
//}
