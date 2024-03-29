//
//  RecordSaveImagePreview.swift
//  Record
//
//  Created by 전지민 on 2023/03/19.
//

import SwiftUI

struct ImageThemeModalView: View {
    
    @Binding var isPresented: Bool
    @Binding var item: Content
    @State var selectedTheme: Themes = .spring
    @State private var showShareSheet = false
    
    @AppStorage ("isLighting") var isLighting = false
    
    var body: some View {
        ZStack {
            RecordColor.recordBackground.fetchColor(isLighting: isLighting)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 30) {
                Text("음악과 어울리는 테마를 선택하세요.")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(RecordColor.recordTitleBlack.fetchColor(isLighting: isLighting))
                
                preview
                
                HStack(spacing: 30) {
                    ForEach(Array(Themes.allCases.enumerated()), id: \.offset) { index, theme in
                        Button {
                            selectedTheme = theme
                        } label: {
                            theme.fetchThemes()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(theme == selectedTheme ? RecordColor.recordTitleBlack.fetchColor(isLighting: isLighting) : .clear, lineWidth: 2)
                                }
                        }
                    }
                }
            }
            .scaleEffect(UIScreen.getWidth(0.75))
            .padding(.bottom, 60)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("이미지 공유")
                        .foregroundColor(RecordColor.recordTitleBlack.fetchColor(isLighting: isLighting))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            actionSheet()
                        }
                    } label: {
                        Text("완료")
                    }
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [self.snapShot()])
            }
        }
    }
    
    func actionSheet() {
        let shareImage = preview.snapShot()
        let activityItemMetadata = MyActivityItemSource(text: "\(item.title!) - \(item.artist!)" , image: shareImage)
        let activityViewController = UIActivityViewController(activityItems: [activityItemMetadata, shareImage], applicationActivities: nil)
        activityViewController.isModalInPresentation = true
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    var preview: some View {
        ZStack {
            
            selectedTheme.fetchThemes().edgesIgnoringSafeArea(.all)
            
            Image("backwindow")
                .padding(.leading, UIScreen.getWidth(90))
                .opacity(0.5)
            
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
                .padding(.horizontal, UIScreen.getWidth(35))
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
                            CDPlayerComponent(music: Music(artist: item.artist ?? "", title: item.title ?? "", albumArt: item.albumArt ?? ""))
                        }
                    }
                    
                    ZStack {
                        HStack {
                            VStack(spacing: UIScreen.getHeight(60)) {
                                
                                // MARK: Image
                                ZStack {
                                    Image("DetailPhotoComp") // 이미지 삽입
                                    
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
        }
    }
    struct ShareSheet: UIViewControllerRepresentable {
        typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
        
        let activityItems: [Any]
        let applicationActivities: [UIActivity]? = nil
        let excludedActivityTypes: [UIActivity.ActivityType]? = nil
        let callback: Callback? = nil
        
        func makeUIViewController(context: Context) -> UIActivityViewController {
            let controller = UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: applicationActivities)
            controller.excludedActivityTypes = excludedActivityTypes
            controller.completionWithItemsHandler = callback
            return controller
        }
        
        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
            // nothing to do here
        }
    }

}
