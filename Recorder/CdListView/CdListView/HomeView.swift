//
//  HomeView.swift
//  CdListView
//
//  Created by 조은비 on 2022/06/13.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: CdListView()) {
                Text("CD LIST")
            }.navigationBarTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
