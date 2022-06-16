import SwiftUI

// 네비게이션 링크 지연시키기 위한 코드
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

// 가운데 오는 cd의 id값과 드래그하는지를 추적하기 위한 클래스입니다!
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

// SmapCarouselView에 cd 리스트를 드래그할때 들어가는 뷰입니다!
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

// cd 하나를 나타내는 뷰입니다!
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
