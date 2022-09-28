//
//  WriteView.swift
//  Recorder
//
//  Created by 최윤석 on 2022/06/13.
//

import SwiftUI

struct WriteView: View {
    
    
    
    // coredata 관련 변수
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Content>
    
    @State private var showingAlert = false // 저장 완료
    @State var music: Music
    @State private var image: Image?                       // 선택된 사진, 어떤 이미지인지
    @State private var showingImagePicker = false           // 이미지 클릭됐는지 확인
    @State private var savestory = false                    // 이야기 클릭됐는지 확인
    @State private var inputImage: UIImage?
    @State private var lyrics = ""
    @State private var content = ""
    
    @Binding var isEdit: Bool
    @State var item: Content?
    @State var index: Int = -1
    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                
                Image("backwindow")
                    .padding(.leading, UIScreen.getWidth(90))
                
                VStack {
                    
                    // MARK: 노래 정보
                    VStack(alignment: .leading, spacing: UIScreen.getHeight(10)) {
                        Text(music.title) // MARK: "music.title"
                            .font(.customTitle2())
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                        
                        Text(music.artist) //MARK: "music.artist"
                            .font(.customBody1())
                            .fontWeight(.regular)
                            .foregroundColor(.titleDarkgray)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, UIScreen.getWidth(35))
                    .padding(.top, UIScreen.getHeight(15))
                    
                    //MARK: - 가사 입력 받는 뷰 시작
                    ZStack {
                        Image("LylicComp") // 가사 입력
                        
                        TextField("\(Image(systemName: "music.mic")) 기억하고 싶은 가사",         // 가사 입력하는 텍스트 필드
                                  text: $lyrics)
                        .font(Font.customBody2())
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.getWidth(240), alignment: .center)
                        .foregroundColor(.titleDarkgray)
                        
                    }
                    .padding(.bottom, UIScreen.getHeight(15))
                    HStack(alignment: .bottom) {
                        //MARK: - // 클릭시 모달을 통해 이미지 띄우는 부분
                        
                        VStack(spacing: UIScreen.getHeight(40)) {
                            ZStack {
                                Image("PhotoComp")
                                
                                image?                       // 사용자가 가져온 이미지를 보여주는 부분
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.getWidth(95), height: UIScreen.getHeight(105))
                                    .clipped()
                                    .scaleEffect()
                                    .offset(y: UIScreen.getHeight(-15))
                                
                            }
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                
                                showingImagePicker = true
                            }
                            .zIndex(1)
                            .onChange(of: inputImage) { _ in loadImage() }
                            .sheet(isPresented: $showingImagePicker) {
                                ImagePicker(image: $inputImage)
                            }
                            
                            // MARK: 이야기 작성 모달뷰로 이동
                            ZStack {
                                Image("StoryComp")
                                
                                if !content.isEmpty {
                                    Text(content)
                                        .font(Font.customBody2())
                                        .foregroundColor(.titleDarkgray)
                                        .lineLimit(5)
                                        .truncationMode(.tail)
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(5)
                                        .frame(width: UIScreen.getWidth(130))
                                } else {
                                    VStack {
                                        Image(systemName: "plus")
                                            .foregroundColor(.titleGray)
                                            .padding(UIScreen.getHeight(5))
                                        Text("나의 음악 이야기")
                                            .foregroundColor(.titleGray)
                                            .font(.customBody1())
                                    }
                                }
                            }
                            .onTapGesture {
                                savestory.toggle()
                                UIView.setAnimationsEnabled(false)
                            }
                            .fullScreenCover(isPresented: $savestory, onDismiss: { savestory = false }, content: {
                                WritingModalView(content: $content)
                            })
                            //MARK: - 이야기 입력 받는 Button 끝
                            .offset(x: UIScreen.getWidth(62))
                        }
                        
                        //MARK: - 이미지 가져오는 부분 끝
                        
                        CDPlayerComp(music: music) //MARK: SearchView에서 music 받아옴
                        //MARK: - CD 플레어이 뷰 시작
                        
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
            }
            
            // 저장 버튼 누르면 Alert 창이 나오고, 홈으로 이동
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEdit {
                        Button("닫기", action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // 하나라도 안 쓰면 저장 버튼 눌리지 않게
                    if content == "" || inputImage == nil || lyrics == "" {
                        Text("저장")
                            .foregroundColor(.titleGray)
                        
                    } else { // 저장버튼 활성화 및 CoreData에 저장
                        Button("저장") {
                            
                            item!.story = content
                            item!.image = inputImage!.pngData()
                            item!.lyrics = lyrics
                            
                            PersistenceController.shared.saveContent()
                            self.showingAlert = true
                            
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("저장 완료"),
                                dismissButton: .default(Text("확인")) {
                                    if isEdit {
                                        presentationMode.wrappedValue.dismiss()
                                    } else {
                                        NavigationUtil.popToRootView()
                                    }
                                })
                        }
                    } // if-else End
                }
            } // tool bar End
        }.onTapGesture {                         // keyboard dismiss
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            if item == nil {
                item = Content(context: viewContext)
                item?.id = UUID()
                item?.date = Date()
            } else {
                self.lyrics = item!.lyrics!
                self.content = item!.story!
                self.inputImage = UIImage(data: item!.image!)
            }
            item!.title = music.title
            item!.artist = music.artist
            item!.albumArt = music.albumArt
            
        }
    } // View End
    
    func loadImage() {      // 이미지 저장하는 함수
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
} // RecordResultView End

struct UserStory {
    var lylic: String
    var story: String
    var image: Data
}

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
    
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(music: Music(artist: "가수이름", title: "노래제목", albumArt: ""), isEdit: .constant(false))
    }
}
