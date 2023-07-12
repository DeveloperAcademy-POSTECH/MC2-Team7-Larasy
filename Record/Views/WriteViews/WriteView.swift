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
    
    @Binding var isWrite: Bool
    @Binding var isEdit: Bool
    @State var item: Content?
    @State var index: Int = -1
    
    @AppStorage ("isLighting") var isLighting = false
    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                RecordColor.recordBackground.fetchColor(isLighting: isLighting)
                    .edgesIgnoringSafeArea(.all)
                
                Image(RecordImage.backwindow.fetchRecordImage(isLighting: isLighting))
                    .padding(.leading, UIScreen.getWidth(90))
                
                Image(RecordImage.moon.fetchRecordImage(isLighting: isLighting))
                    .padding(.bottom, UIScreen.getHeight(60))
                    .padding(.trailing, UIScreen.getWidth(40))
                
                VStack {
                    
                    // MARK: 노래 정보
                    VStack(alignment: .leading, spacing: UIScreen.getHeight(10)) {
                        Text(music.title)
                            .font(.customTitle2())
                            .fontWeight(.bold)
                            .foregroundColor(RecordColor.recordTitleBlack.fetchColor(isLighting: isLighting))
                            .multilineTextAlignment(.leading)
                        
                        Text(music.artist)
                            .font(.customBody1())
                            .fontWeight(.regular)
                            .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, UIScreen.getWidth(35))
                    .padding(.top, UIScreen.getHeight(15))
                    
                    ZStack {
                        VStack(spacing: 40) {
                            
                            // MARK: 가사 입력
                            ZStack {
                                Image(RecordImage.lylicComp.fetchRecordImage(isLighting: isLighting))
                                
                                TextField("\(Image(systemName: "music.mic")) 기억하고 싶은 가사", text: $lyrics)
                                    .font(Font.customBody2())
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.center)
                                    .frame(width: UIScreen.getWidth(240), alignment: .center)
                                    .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                                
                            }
                            
                            // MARK: CD Player
                            HStack {
                                Spacer()
                                CDPlayerComponent(music: music)
                            }
                        }
                        
                        
                        ZStack {
                            HStack {
                                VStack(spacing: UIScreen.getHeight(60)) {
                                    
                                    //MARK: 폴라로이드
                                    ZStack {
                                        Image(RecordImage.photoComp.fetchRecordImage(isLighting: isLighting))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(153))
                                        
                                        image?                       // 사용자가 가져온 이미지를 보여주는 부분
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.getWidth(90), height: UIScreen.getHeight(100))
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
                                    .padding(.top, UIScreen.getHeight(30))
                                    
                                    // MARK: 이야기 작성 모달 뷰
                                    ZStack {
                                        Image(RecordImage.storyComp.fetchRecordImage(isLighting: isLighting))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(150))
                                        
                                        if !content.isEmpty {
                                            Text(content)
                                                .font(Font.customBody2())
                                                .foregroundColor(RecordColor.recordTitleDarkgray.fetchColor(isLighting: isLighting))
                                                .lineLimit(5)
                                                .truncationMode(.tail)
                                                .multilineTextAlignment(.leading)
                                                .lineSpacing(5)
                                                .frame(width: UIScreen.getWidth(130))
                                        } else {
                                            VStack {
                                                Image(systemName: "plus")
                                                    .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                                                    .padding(UIScreen.getHeight(5))
                                                Text("나의 음악 이야기")
                                                    .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                                                    .font(.customBody1())
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            savestory.toggle()
                                        }
                                    }
                                    .offset(x: UIScreen.getWidth(62))
                                }
                                
                                Spacer()
                            }
                            .padding(.top, UIScreen.getHeight(130))
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                
                if savestory {
                    WritingModalView(content: $content, isPresented: $savestory)
                }
            }
            .navigationBarBackButtonHidden(true)
            // 저장 버튼 누르면 Alert 창이 나오고, 홈으로 이동
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEdit {
                        if isWrite {
                            Button {
                                PersistenceController.shared.deleteContent(item: item ?? Content())
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                        .font(Font.headline.weight(.semibold))
                                    Text("음악 선택")
                                }
                                .foregroundColor(savestory ? .clear : .pointBlue)
                            }
                        } else {
                            Button ("닫기") {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .foregroundColor(savestory ? .clear : .pointBlue)
                        }
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // 하나라도 안 쓰면 저장 버튼 눌리지 않게
                    if content == "" || inputImage == nil || lyrics == "" {
                        Text("저장")
                            .foregroundColor(RecordColor.recordTitleGray.fetchColor(isLighting: isLighting))
                        
                    } else { // 저장버튼 활성화 및 CoreData에 저장
                        Button("저장") {
                            
                            item!.story = content
                            item!.image = inputImage!.jpegData(compressionQuality: 1)
                            item!.lyrics = lyrics
                            
                            PersistenceController.shared.saveContent()
                            self.showingAlert = true
                            
                        }
                        .foregroundColor(savestory ? .clear : .pointBlue)
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("저장 완료"),
                                dismissButton: .default(Text("확인")) {
                                    if isEdit && !isWrite {
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
        WriteView(music: Music(artist: "가수이름", title: "노래제목", albumArt: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"), isWrite: .constant(true), isEdit: .constant(false))
    }
}
