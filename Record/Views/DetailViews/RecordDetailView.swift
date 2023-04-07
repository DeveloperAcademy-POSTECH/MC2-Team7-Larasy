//
//  RecordDetailView.swift
//  Recorder
//
//  Created by 김보승 on 2022/06/13.
//


import SwiftUI
import CoreData
import LinkPresentation

struct RecordDetailView: View {
    
    //coredata 관련 변수
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @Binding var item: Content
    
    @State private var isPresentedPhotoView = false
    @State private var isPresentedStoryView = false
    @State private var isPresentedDeleteAlert = false
    @State private var isTappedSaveButton = false
    @State private var isTappedEditButton = false
    
    var body: some View {
        
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            Image("backwindow")
                .padding(.leading, UIScreen.getWidth(90))
            
            VStack {
                // MARK: 노래 정보
                VStack(alignment: .leading, spacing: UIScreen.getHeight(10)) {
                    Text(item.title ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.titleBlack)
                        .multilineTextAlignment(.leading)
                    Text(item.artist ?? "")
                        .font(.customBody1())
                        .fontWeight(.regular)
                        .foregroundColor(.titleDarkgray)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.leading, UIScreen.getWidth(35))
                .padding(.top, UIScreen.getHeight(15))
                
                
                ZStack {
                    VStack(spacing: 40) {
                        
                        // MARK: - 가사
                        ZStack {
                            Image("LylicComp")
                            
                            Text(item.lyrics ?? "")
                                .foregroundColor(.titleDarkgray)
                                .font(.customBody2())
                                .frame(width: UIScreen.getWidth(240), alignment: .center)
                        }
                        
                        // MARK: CD Player
                        HStack {
                            Spacer()
                            CDPlayerComponent(music: Music(artist: item.artist ?? "",
                                                           title: item.title ?? "",
                                                           albumArt: item.albumArt ?? ""))
                        }
                    }
                    
                    ZStack {
                        HStack {
                            VStack(spacing: UIScreen.getHeight(60)) {
                                
                                // MARK: Image
                                ZStack {
                                    Image("DetailPhotoComp")
                                    
                                    if let image = item.image {
                                        Image(uiImage: UIImage(data: image)!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 95, height: 105)
                                            .clipped()
                                            .scaleEffect()
                                            .offset(y: UIScreen.getHeight(-15))
                                    }
                                }
                                .onTapGesture {
                                    withAnimation {
                                        isPresentedPhotoView.toggle()
                                    }
                                }
                                .padding(.top, UIScreen.getHeight(30))
                                
                                // MARK: Story
                                ZStack {
                                    
                                    Image("StoryComp")
                                    
                                    Text(item.story ?? "")
                                        .font(Font.customBody2())
                                        .foregroundColor(.titleDarkgray)
                                        .lineLimit(5)
                                        .truncationMode(.tail)
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(5)
                                        .frame(width: UIScreen.getWidth(130))
                                }
                                .onTapGesture {
                                    withAnimation {
                                        isPresentedStoryView.toggle()
                                    }
                                }
                                .fixedSize()
                                .offset(x: UIScreen.getWidth(62))
                            }
                            Spacer()
                        }
                        .padding(.top, UIScreen.getHeight(150))
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .onTapGesture {
                withAnimation {
                    self.isPresentedPhotoView = false
                    self.isPresentedStoryView = false
                }
            }
            
            if isPresentedPhotoView, let image = item.image {
                PhotoModalView(isPresented: $isPresentedPhotoView, image: image)
            }
            
            if isPresentedStoryView, let myStory = item.story {
                StoryModalView(isPresented: $isPresentedStoryView, content: myStory)
            }
        }
        .navigationBarBackButtonHidden(isPresentedPhotoView || isPresentedStoryView)
        .toolbar {
            Menu {
                // MARK: 편집 기능
                Button {
                    isTappedEditButton.toggle()
                } label: {
                    Label("편집", systemImage: "square.and.pencil")
                }
                
                // MARK: 이미지 저장 기능
                Button {
                    actionSheet()
                } label: {
                    Label("이미지 공유", systemImage: "square.and.arrow.up")
                }
                
                // MARK: 삭제 기능
                Button(role: .destructive) {
                    isPresentedDeleteAlert = true
                } label: {
                    Label("제거", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .padding(.vertical, 10)
                    .foregroundColor(isPresentedPhotoView || isPresentedStoryView ? .clear : .pointBlue)
            }
        }
        .fullScreenCover(isPresented: $isTappedEditButton) {
            NavigationView {
                WriteView(music: Music(artist: item.artist!,
                                       title: item.title!,
                                       albumArt: item.albumArt!),
                          isWrite: .constant(false),
                          isEdit: .constant(true),
                          item: item)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .alert("삭제", isPresented: $isPresentedDeleteAlert) {
            Button("삭제", role: .destructive) {
                PersistenceController.shared.deleteContent(item: item)
                presentation.wrappedValue.dismiss()
            }
        } message: { Text("정말 삭제하시겠습니까?") }
        // 본문 ZStack End
            .alert("저장완료", isPresented: $isTappedSaveButton) {
                Button("확인") {
                }
            } message: {  }
        // 본문 ZStack End
    }
    
    func actionSheet() {
        let shareImage = self.snapShot()
        let activityItemMetadata = MyActivityItemSource(text: "\(item.title!) - \(item.artist!)" , image: shareImage)
        let activitiViewController = UIActivityViewController(activityItems: [activityItemMetadata, shareImage], applicationActivities: nil)
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController?.present(activitiViewController, animated: true, completion: nil)
    }
}

//출처: https://developer.apple.com/forums/thread/687916
class MyActivityItemSource: NSObject, UIActivityItemSource {
    var title: String = "RE:CORD"
    var text: String
    var image: UIImage
    
    init(text: String, image: UIImage) {
        self.text = text
        self.image = image
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.iconProvider = NSItemProvider(object: UIImage(imageLiteralResourceName: "AppIcon") )
        metadata.originalURL = URL(fileURLWithPath: text)
        return metadata
    }
}
