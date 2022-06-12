//
//  SnapCarousel.swift
//  CdListView
//
//  Created by 조은비 on 2022/06/12.
//

//import SwiftUI
//
//    struct SnapCarousel <Content: View, T: Identifiable>: View {
//
//        var content: (T) -> Content
//        var list: [T]
//
//        var spacing: CGFloat
//        var trailingSpace: CGFloat
//        @Binding var index: Int
//
//        init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
//
//            self.list = items
//            self.spacing = spacing
//            self.trailingSpace = trailingSpace
//            self._index = index
//            self.content = content
//        }
//
//        var body: some View {
//
//            GeometryReader {proxy in
//
//                ForEach(list) {item in
//                    content(item)

//                }
//            }
//            .padding( .horizontal, spacing)
//        }
//    }
////
////struct SnapCarousel_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
