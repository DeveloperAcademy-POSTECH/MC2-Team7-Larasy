//
//  SearchView.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//

import SwiftUI
import UIKit

struct SearchView: View {
    
    @State private var list = (1111...1121).map{String($0) }
    
    init() { UITableView.appearance().backgroundColor = UIColor.clear }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("기록을 통해 기억하고 싶은 음악을 알려주세요")
                .frame(width: 300)
                .font(.system(size: 24, weight: .bold))
            
            SearchBar()
            
            List {
                ForEach(self.list, id: \.self) { num in
                    HStack {
                        Image(systemName: "photo")
                            .cornerRadius(5)
                            .frame(width: 55, height: 55)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 4))
                        
                        VStack {
                            Text(num)
                                .font(.system(size: 17, weight: .bold))
                                .padding(6)
                            Text(num)
                                .font(.system(size: 17))
                        }
                    }
                }
                .padding()
            }
            .listStyle(.sidebar)
        }
    }
    
}


struct SearchBar: View {
    
    @State var search = ""
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("기록하고 싶은 음악, 가수를 입력하세요", text: $search)
            }
            .foregroundColor(.gray)
            .padding(13)
        }
        .frame(height: 40)
        .cornerRadius(10)
        .padding(20)
        
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
