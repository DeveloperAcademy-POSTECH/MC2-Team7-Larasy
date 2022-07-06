//
//  SearchView.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/12.
//

import SwiftUI
import UIKit


// MARK: - 음악 검색 View
struct SearchView: View {
    
    @StateObject var musicAPI = MusicAPI()
    @State var search = ""
    private let placeholer = "기록하고 싶은 음악, 가수를 입력하세요"
    
    init() { UITableView.appearance().backgroundColor = UIColor.clear } // 검색 결과 출력 리스트 배경색 초기화
    
    var body: some View {
        
        ZStack {
            Color.background // 배경색 설정
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("오랫동안 간직하고 싶은 나만의 음악을 알려주세요") // 최상단 title 설정
                    .frame(width: 250)
                    .font(.customTitle2())
                    .lineSpacing(7)
                    .foregroundColor(.titleBlack)
                    .padding(.top, 30)
                    .padding(.leading, 20)
                
                SearchBar // 중앙 서치바,
                
                ResultView // 하단 검색 결과 출력 리스트
                
            } //VStack End
            
        } // ZStack End
        .navigationBarTitle("음악 선택", displayMode: .inline)
        
    } // body View End
    
    
    
    //MARK: - 서치바
    var SearchBar: some View {
        
        ZStack {
            Rectangle() // 서치바 배경
                .foregroundColor(.titleLightgray)
            
            HStack {
                Image(systemName: "magnifyingglass") // 돋보기 Symbol
                
                TextField("", text: $search) // 입력창
                    .foregroundColor(.titleBlack)
                    .font(.customBody2())
                    .onSubmit { // keyboard Return Button 클릭 시
                        musicAPI.getSearchResults(search: search) // 음악 API 불러오기
                    }
                    .placeholder(when: search.isEmpty) {
                        Text(placeholer)
                            .foregroundColor(.titleDarkgray)
                            .font(.customBody2())
                    }
                    
                if search != "" { // X 버튼 활성화
                    Image(systemName: "xmark.circle.fill") // x버튼 이미지
                        .imageScale(.medium)
                        .foregroundColor(.titleGray)
                        .padding(3)
                        .onTapGesture {
                            withAnimation {
                                self.search = ""
                            }
                        }
                }
            } // HStack End
            .foregroundColor(.titleDarkgray)
            .padding(13)
            
        } // 배경색 ZStack End
        .frame(height: 40)
        .cornerRadius(10)
        .padding(10)
        .padding(.horizontal, 10)
        
    } // SearchBar View End
    
    
    
    // MARK: - 검색 결과 리스트
    var ResultView: some View {
        
        GeometryReader { geometry in
            
            // 검색 결과 리스트
            List {
                ForEach(musicAPI.musicList, id: \.self) { music in
                    
                    // 앨범 커버, 제목, 가수 출력
                    HStack {
                        URLImage(urlString: music.albumArt) // 앨범커버
                            .cornerRadius(5)
                            .frame(width: 55, height: 55)
                        
                        // 글 작성 페이지로 전환
                        NavigationLink(destination: WriteView(userContent: UserContent(music: music, lyric: "", image: nil, story: ""), isEdit: .constant(false), item: nil)) {
                         
                            // 제목, 가수 출력
                            VStack(alignment: .leading) {
                                Text(music.title) // 노래제목
                                    .font(.customHeadline())
                                    .lineLimit(1)
                                    .padding(.bottom, 2)
                                
                                Text(music.artist) // 가수명
                                    .font(.customBody2())
                                    .lineLimit(1)
                            }
                            .padding(.leading, 10)
                            .foregroundColor(.titleDarkgray)
                        } // Navigation Link End
                        
                        .buttonStyle(PlainButtonStyle())
                    } // HStack End
                }
                .listRowBackground(Color.background)
                .listRowSeparator(.hidden)
                .padding([.bottom, .top], 10)
                .padding([.leading], -20)
                
            } // List End
            .onAppear { UITableView.appearance().contentInset.top = -35 }
            
        } // GeometryReder End
        
    } // ResultView View End
    
} //SearchView struct End



// MARK: - 앨범 커버 불러오기
struct URLImage: View {
    
    @State var data: Data?
    let urlString: String
    
    var body: some View {
        
        // 앨범 커버 불러오기
        if let data = data, let uiimage = UIImage(data: data) { // 이미지 불러오기 성공
            
            Image(uiImage: uiimage) // URL Image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(.gray)
                .onAppear() { fetchData() }
            
        } else { // 이미지 불러오기 실패
            
            Rectangle() // 회색 박스
                .foregroundColor(.titleLightgray)
                .aspectRatio(contentMode: .fit)
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


// MARK: - 현재 뷰 프리뷰
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
