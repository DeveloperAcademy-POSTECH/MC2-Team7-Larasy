//
//  TestSoiView.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/13.
//

import SwiftUI

struct TestSoiView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Content>
    
    //let music: Music
    
    var body: some View {
        VStack {
            List {
                ForEach(items.indices, id: \.self) { item in
                    NavigationLink {
                        Text("Item at \(items[item].title!)")
                    } label: {
                        Text(items[item].title!)
                        Text(items[item].lyrics!)
                        Text(items[item].story!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        //        VStack {
        //            Text(music.title) // 음악 이름
        //            Text(music.artist) // 가수 이름
        //            URLImage(urlString: music.albumArt) //앨범 커버
        //
        //            Rectangle()
        //                .frame(width: 100, height: 100)
        //                .onTapGesture { // TODO: 본문 뷰에서 사용할 함수
        //                    // 갤러리에 저장
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        let image = body.screenshot()
//                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)}
//                }
//        }
        .navigationTitle("Detail")
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
