//
//  SearchView.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//

import SwiftUI
import UIKit

struct SearchView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var search = ""
    
    init() { UITableView.appearance().backgroundColor = UIColor.clear }
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("오랫동안 간직하고 싶은 나만의 음악을 알려주세요")
                    .frame(width: 300)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    
                
                //search bar
                ZStack {
                    Rectangle()
                        .foregroundColor(.lightgray)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("기록하고 싶은 음악, 가수를 입력하세요", text: $search)
                            .foregroundColor(.darkgray)
                            .onSubmit {
                                viewModel.getSearchResults(search: search)
                            }
                        if search != "" {
                            Image(systemName: "xmark.circle.fill")
                                        .imageScale(.medium)
                                        .foregroundColor(Color(.systemGray3))
                                        .padding(3)
                                        .onTapGesture {
                                            withAnimation {
                                                self.search = ""
                                              }
                                        }
                        }
                    }
                    .foregroundColor(.darkgray)
                    .padding(13)
                }
                .frame(height: 40)
                .cornerRadius(10)
                .padding(20)
                
                
                // result view
                GeometryReader { geometry in
                    List {
                        ForEach(viewModel.musicList, id: \.self) { music in
                            HStack {
                                URLImage(urlString: music.artworkUrl100)
                                    .cornerRadius(5)
                                
                                VStack(alignment: .leading) {
                                    Text(music.trackName)
                                        .font(.system(size: 17, weight: .bold))
                                        .lineLimit(1)
                                        .padding(.bottom, 2)
                                    Text(music.artistName)
                                        .font(.system(size: 15))
                                }
                                .padding(.leading, 10)
                                .foregroundColor(.darkgray)
                            }
                        }
                        .listRowBackground(Color.background)
                        .listRowSeparator(.hidden)
                        .padding(8)
                    }
                    .onAppear { UITableView.appearance().contentInset.top = -35 }
                }
            }
        }
        .navigationBarTitle("음악 선택", displayMode: .inline)
    }
}

struct URLImage: View {
    
    @State var data: Data?
    let urlString: String
    
    var body: some View {
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .background(.gray)
            
        } else {
            Rectangle()
                .foregroundColor(.lightgray)
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .onAppear() {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
