import SwiftUI

struct SnapCarousel: View {
    @State private var angle = 0.0 // cd ratation angle 초기값
    @EnvironmentObject var UIState: UIStateModel
    @State var showCd: Bool = false // cd player에 cd 나타나기
    @State var showDetailView = false // detailView 나타나기
    @State var value: Int = 0
    @State var selectedCd: Int = 0
    @State var currentCd: Int = 0
    //    @State var tapGesture: Bool = false
    
    var body: some View {
        let spacing: CGFloat = -20
        let widthOfHiddenCds: CGFloat = 100
        let cdHeight: CGFloat = 279
        
        // 기록물 id, 곡제목, 가수명, 앨범커버 배열 예시
        let cds = [
            Cd(id: 0, musicTitle: "노래제목1", singer: "가수명1", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"),
            Cd(id: 1, musicTitle: "노래제목2", singer: "가수명2", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/17/ff/63/17ff63de-3aba-0f2d-63e7-50d66f900ebb/21UMGIM43558.rgb.jpg/100x100bb.jpg"),
            Cd(id: 2, musicTitle: "노래제목3", singer: "가수명3", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg"),
            Cd(id: 3, musicTitle: "노래제목4", singer: "가수명4", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/17/ff/63/17ff63de-3aba-0f2d-63e7-50d66f900ebb/21UMGIM43558.rgb.jpg/100x100bb.jpg"),
            Cd(id: 4, musicTitle: "노래제목5", singer: "가수명5", image: "https://is3-ssl.mzstatic.com/image/thumb/Music122/v4/f7/68/9c/f7689ce3-6d41-60cd-62d2-57a91ddf5b9d/196922067341_Cover.jpg/100x100bb.jpg")
        ]
        
        // https://gist.github.com/xtabbas/97b44b854e1315384b7d1d5ccce20623.js 의 샘플코드를 참고했습니다.
        return Canvas {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                // Carousel 슬라이더 기능
                // ForEach로 items마다 Item() 뷰를 각각 불러옴
                VStack {
                    Carousel(
                        numberOfItems: CGFloat(cds.count),
                        spacing: spacing,
                        widthOfHiddenCds: widthOfHiddenCds
                    ) {
                        ForEach(cds, id: \.self.id) { content in
                            Item(
                                _id: Int(content.id),
                                spacing: spacing,
                                widthOfHiddenCds: widthOfHiddenCds,
                                cdHeight: cdHeight
                            ) {
                                VStack {
                                    if (content.id == UIState.activeCard) {
                                        Text("\(content.musicTitle) - \(content.singer)")
                                            .foregroundColor(Color.titleBlack)
                                            .font(Font.customTitle3())
                                            .padding(.bottom, 30)
                                    } else {
                                        Spacer()
                                            .frame(height: 50)
                                    }
                                    Button(action: {
                                        if self.showCd {
                                            self.showCd = false
                                            self.selectedCd = self.currentCd
                                            
                                        } else {
                                            self.showCd = true
                                            self.selectedCd = content.id
                                            self.currentCd = self.selectedCd
                                        }
                                        
                                    }) {
                                        ZStack {
                                            URLImage(urlString: content.image)
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                                            Circle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.background)
                                        }
                                    } // 버튼
                                    .disabled(UIState.activeCard != content.id)
                                    .onChange(of: UIState.activeCard) { newCd in
                                        if newCd != selectedCd {
                                            self.showCd = false
                                        }
                                    }
                                } // V 스택
                            }
                            .transition(AnyTransition.slide)
                            .animation(.spring())
                        } // ForEach
                    }
                    .padding(.top, 150)
                    
                    Spacer()
                    // CdPlayer
                    ZStack {
                        Image("CdPlayer")
                        
                        // cd 클릭시, cdPlayer에 cd 나타남
                        VStack {
                            if showCd == true {
                                NavigationLink(destination: RecordDetailView(), isActive: $showDetailView) {
                                    URLImage(urlString: cds[selectedCd].image)
                                        .clipShape(Circle())
                                        .frame(width: 110, height: 110)
                                        .rotationEffect(.degrees(self.angle))
                                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                        .onTapGesture {
                                            self.angle += Double.random(in: 1000..<1980)
                                            timeCount()
                                        }
                                }
                            } else {
                                NavigationLink(destination: RecordDetailView(), isActive: $showDetailView) {
                                    URLImage(urlString: cds[selectedCd].image)
                                        .clipShape(Circle())
                                        .frame(width: 110, height: 110)
                                        .rotationEffect(.degrees(self.angle))
                                        .animation(.timingCurve(0, 0.8, 0.2, 1, duration: 10), value: angle)
                                        .onTapGesture {
                                            self.angle += Double.random(in: 1000..<1980)
                                            timeCount()
                                        }
                                }
                                
                            }
                        }
                        .padding(.bottom, 180)
                        .padding(.leading, 2) // CdPlayer를 그림자 포함해서 뽑아서 전체 CdPlayer와 정렬 맞추기 위함
                        
                        // cdPlayer 가운데 원
                        VStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.titleLightgray)
                                    .frame(width: 30 , height: 30)
                                Circle()
                                    .foregroundColor(.titleDarkgray)
                                    .frame(width: 15 , height: 15)
                                    .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
                                Circle()
                                    .foregroundColor(.background)
                                    .frame(width: 3 , height: 3)
                            } // Z스택
                        } // V스택
                        .padding(.bottom, 180)
                        .padding(.leading, 4)
                    } // Z스택
                } // V스택
                .ignoresSafeArea()
            } // Z스택
            //                } // if문
        } // Canvas
        .navigationBarTitle("List", displayMode: .inline)
    } // 바디 뷰
    
    func timeCount() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.value += 1
            
            if self.value == 1 {
                self.showDetailView = true
                self.value = 0
                
                return
            }
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}


// 기록한 Cd 구조체
struct Cd: Identifiable, Hashable {
    var id: Int
    var musicTitle: String = ""
    var singer: String = ""
    var image: String = ""
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false // 드래그하고 있는지 파악하기 위함
    
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCds: CGFloat,
        @ViewBuilder _ items: () -> Items) {
            
            self.items = items()
            self.numberOfItems = numberOfItems
            self.spacing = spacing
            self.widthOfHiddenCards = widthOfHiddenCds
            self.totalSpacing = (numberOfItems - 1) * spacing
            self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCds * 2) - (spacing * 2)
        }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            // 뒤로 스크롤
            if (value.translation.width < -10 && CGFloat(self.UIState.activeCard) < numberOfItems - 1) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred() // haptic 피드백
            }
            // 앞으로 스크롤
            if (value.translation.width > 10 && CGFloat(self.UIState.activeCard) > 0) {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred() // haptic 피드백
            }
        })
    }
}

struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cdWidth: CGFloat
    let cdHeight: CGFloat
    
    var _id: Int
    var content: Content
    
    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCds: CGFloat,
        cdHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cdWidth = UIScreen.main.bounds.width - (widthOfHiddenCds*2) - (spacing*2) // 중심에 있는 cd 넓이
        self.cdHeight = cdHeight
        self._id = _id
    }
    
    var body: some View {
        content
            .frame(width: cdWidth, height: _id == UIState.activeCard ? cdHeight : cdHeight - 90, alignment: .center) // 양옆에 있는 cd는 높이만 줄여줌
    }
}
