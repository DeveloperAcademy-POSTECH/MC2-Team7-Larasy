//
//  ContentView.swift
//  CdListView
//
//  Created by 조은비 on 2022/06/11.
//
//
//import SwiftUI

//struct CdListView: View {
//
//    @State var currentIndex: Int = 0
//    @State var albums: [Album] = []
//
//    var body: some View {
//
////        ScrollView(.horizontal, showsIndicators: false) {
////            HStack(spacing: 16) {
////                ForEach(0 ..< 5) { item in
////                    GeometryReader { geometry in
////                        RoundedRectangle(cornerRadius: 30)
////                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
////                            .rotation3DEffect(
////                                Angle(
////                                    degrees: Double((geometry.frame(in: .global).minX - 20) / -20)
////                                ),
////                                axis: (x: 0, y: 1, z: 0),
////                                anchor: .center,
////                                anchorZ: 0.0,
////                                perspective: 1.0
////                            )
////                    }
////                    .frame(width: 300, height: 300)
////                }
////            }
////            .padding()
////        }
//
//        SnapCarousel(index: $currentIndex, items: albums) {
//            album in
//
//            GeometryReader {proxy in
//
//                let size = proxy.size
//
//                Image(album.albumImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)

//                    .cornerRadius(12)
//            }
//        }

//            .onAppear {
//                for index in 1...10 {
//                    albums.append(Album(albumImage: "album\(index)"))
//                }
//            }
//
//    }
//}
//
//struct CdListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CdListView()
//    }
//}
