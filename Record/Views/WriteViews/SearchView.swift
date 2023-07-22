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
    
    @ObservedObject var musicAPI: MusicAPI = .searchMusic
    @State var search = ""
    @State var searchChecker = true
    @State var progress: Bool
    private let placeholer = "기록하고 싶은 음악, 가수를 입력하세요".localized
    private let notMusic = "검색 결과가 없습니다."
    private let notMusicDescription = """
     ∙철자와 띄어쓰기를 확인해주세요.
     ∙새로운 검색을 시도해주세요.
    """
    @FocusState private var isSearchbarFocused: Bool?
    @State var isAcessFirst: Bool
    
    @AppStorage ("isLighting") var isLighting = false
    
    init(isAccessFirst: Bool) {
        // 검색 결과 출력 리스트 배경색 초기화
        UITableView.appearance().backgroundColor = UIColor.clear
        
        self.progress = false
        self.isAcessFirst = isAccessFirst
    }
    
    var body: some View {
        
        ZStack {
            RecordColor.recordBackground.fetchColor(isLighting: isLighting)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("오랫동안 간직하고 싶은 나만의 음악을 알려주세요".localized) // 최상단 title 설정
                    .font(.customTitle2())
                    .lineSpacing(7)
                    .foregroundColor(RecordColor.recordTitleBlack.fetchColor(isLighting: isLighting))
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                
                SearchBar // 중앙 서치바,
                
                ResultView // 하단 검색 결과 출력 리스트
                
            } //VStack End
            
        } // ZStack End
        .navigationBarTitle("음악 선택".localized, displayMode: .inline)
        
    } // body View End
    
    
    
    //MARK: - 서치바
    var SearchBar: some View {
        
        ZStack {
            Rectangle() // 서치바 배경
                .foregroundColor(RecordColor.recordTitleLightgray.fetchColor(isLighting: isLighting))
                
            HStack {
                Image(systemName: "magnifyingglass") // 돋보기 Symbol
                
                TextField("", text: $search) // 입력창
                    .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                    .font(.customBody2())
                    .focused($isSearchbarFocused, equals: true)
                    .disableAutocorrection(true)
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            isSearchbarFocused = true
                        }
                    }
                    .onChange(of: search, perform: { _ in
                        progress = true
                        musicAPI.getSearchResults(search: search) // 음악 API 불러오기
                    })
                    .placeholder(when: search.isEmpty) {
                        Text(placeholer)
                            .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                            .font(.customBody2())
                    }
                
                if search != "" { // X 버튼 활성화
                    Image(systemName: "xmark.circle.fill") // x버튼 이미지
                        .imageScale(.medium)
                        .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                        .padding(3)
                        .onTapGesture {
                            withAnimation {
                                self.search = ""
                                progress = false
                            }
                        }
                }
                
                
            } // HStack End
            .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
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
            
            if progress && search != "" && musicAPI.musicList.isEmpty {
                if searchChecker {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .padding(180)
                        .onAppear {
                            self.searchChecker = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                self.searchChecker = false
                            }
                        }
                } else {
                    VStack {
                        HStack {
                            Text(notMusic)
                            Spacer()
                        }
                        .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                        .font(.customSubhead())
                        .padding([.leading, .bottom], 10)
                        
                        Text(notMusicDescription)
                            .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                            .font(.customBody2())
                            .padding(.trailing, 100)
                    }
                    .padding(20)
                    .onDisappear{
                        self.searchChecker = true
                    }
                }
            }
            
            // 검색 결과 리스트
            List {
                ForEach(musicAPI.musicList, id: \.self) { music in
                    
                    // 앨범 커버, 제목, 가수 출력
                    HStack {
                        URLImage(urlString: music.albumArt) // 앨범커버
                            .cornerRadius(5)
                            .frame(width: 55, height: 55)
                        
                        // 글 작성 페이지로 전환
                        NavigationLink(destination: WriteView(music: music, isWrite: .constant(true) ,isEdit: .constant(true), item: nil)) {
                            
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
                            .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                        } // Navigation Link End
                        
                        .buttonStyle(PlainButtonStyle())
                    } // HStack End
                }
                .listRowBackground(RecordColor.recordBackground.fetchColor(isLighting: isLighting))
                .listRowSeparator(.hidden)
                .padding([.bottom, .top, .trailing], 10)
                
            } // List End
            .listStyle(.plain)
            .onAppear() {
                if isAcessFirst {
                    self.musicAPI.musicList = []
                    isAcessFirst = false
                }
            }
            
        } // GeometryReder End
        
    } // ResultView View End
    
} //SearchView struct End


// MARK: - 현재 뷰 프리뷰
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isAccessFirst: true)
    }
}
