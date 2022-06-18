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
    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                RecordBackground()
                VStack{
                    HStack{
                        Spacer()
                    }.padding(.trailing)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(music.title)") // MARK: "music.title"
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.titleBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text("\(music.artist)") //MARK: "music.artist"
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.titleDarkgray)
                        Spacer()
                    }// MusicInform VStack End
                    .padding(.top, 10)
                    Spacer()
                } // MusicImform HStack End
                .padding(.leading, 28)
                
                ZStack {
                    HStack(alignment: .center) {
                        //MARK: - // 클릭시 모달을 통해 이미지 띄우는 부분
                        ZStack{
                            Image("PhotoComp")
                                .padding()
                            
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                                .offset(y: -15)
                            
                            image?                       // 사용자가 가져온 이미지를 보여주는 부분
                                .resizable()
                                .scaledToFill()
                                .frame(width: 95, height: 105)
                                .clipped()
                                .scaleEffect()
                                .offset(y: -15)
                            
                        }
                        .onTapGesture {
                            showingImagePicker = true
                        }
                        .offset(y: -110)
                        .zIndex(1)
                        .onChange(of: inputImage) { _ in loadImage() }
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                        //MARK: - 이미지 가져오는 부분 끝
                        Spacer()
                        
                        //MARK: - CD 플레어이 뷰 시작
                        
                        CDPlayerComp(music: music) //MARK: SearchView에서 music 받아옴
                            .offset(y: -10)
                    }.offset(y: 80)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        
                        //MARK: - 가사 입력 받는 뷰 시작
                        ZStack {
                            Image("LylicComp") // 가사 입력
                                .offset(y: 130)
                            HStack{
                                
                                TextField("\(Image(systemName: "music.mic"))기억하고 싶은 가사",         // 가사 입력하는 텍스트 필드
                                          text: $lyrics)
                                .font(Font.customBody1())
                                .disableAutocorrection(true)
                                .multilineTextAlignment(.center)
                                .frame(width: 240,alignment: .center)
                                
                            }
                            .offset(y: 130)
                        }
                        
                        Spacer()
                        
                        // MARK: - 모달을 통해 이야기 작성하는 뷰 시작
                        Button(action: { savestory.toggle()
                            UIView.setAnimationsEnabled(false)},
                               label: {
                            Image("StoryComp") // 스토리 입력
                                .fullScreenCover(isPresented: $savestory, onDismiss: { savestory = false }, content: {
                                    WritingModalView(content: $content)
                                })
                            if !content.isEmpty {
                                Text(content)
                                    .font(Font.customBody1())
                                    .foregroundColor(.titleDarkgray)
                                    .lineLimit(5)
                                    .truncationMode(.tail)
                                    .frame(width: 130)
                                    .offset(x: -160)
                            }
                        })
                        .offset(x: 20,y: -100)
                        //MARK: - 이야기 입력 받는 Button 끝
                    }.offset(y: -20)
                    
                    Spacer()
                    
                }
            }
            
            // 저장 버튼 누르면 Alert 창이 나오고, 홈으로 이동
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // 하나라도 안 쓰면 저장 버튼 눌리지 않게
                    if content == "" || inputImage == nil || lyrics == "" {
                        Text("저장")
                            .foregroundColor(.titleGray)
                        
                    } else { // 저장버튼 활성화 및 CoreData에 저장
                        Button("저장") {
                            let newItem = Content(context: viewContext)
                            newItem.title = music.title
                            newItem.artist = music.artist
                            newItem.albumArt = music.albumArt
                            newItem.story = content
                            newItem.image = inputImage!.pngData()
                            newItem.lylic = lyrics
                            
                            do {
                                try viewContext.save()
                            } catch { // TODO: error 처리
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            self.showingAlert = true
                            
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("저장 완료"),
                                dismissButton: .default(Text("확인")) {
                                    NavigationUtil.popToRootView()
                                })
                        }
                    } // if-else End
                }
            } // tool bar End
        }.ignoresSafeArea(.keyboard, edges: .bottom)
        
    } // View End
    
    func loadImage() {      // 이미지 저장하는 함수
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    
} // RecordResultView End

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(music: Music(artist: "sunwoojunga", title: "Cat (feat.IU)", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"))
    }
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
