//
//  Persistence.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/17.
//

import CoreData
import UIKit
//import SwiftUI

// MARK: - CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Record")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO: Error 처리
                /* Error 발생 경우
                    - 파일을 만들 수 없거나, 쓰기를 허용하지 않았을 때
                    - 장치의 공간이 부족할 때 */
                
                fatalError("Unresolved error \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContent() {
        do {
            try container.viewContext.save()
        } catch {
//            print(error.localizedDescription)
            let nsError = error as NSError
            fatalError("error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchContent() -> [Content] {
        let request = Content.fetchRequest()
        
        do {
            let contentArray = try context.fetch(request)
            return contentArray
        } catch {
            print("fetch content error")
        }
        saveContent()
        
    return [Content()]
        
    }
    
    func createContent(title: String, artist: String, albumArt: String,
                       story: String, image: UIImage, lyrics: String, date: Date) {
        let newItem = Content(context: container.viewContext)
        newItem.id = UUID()
        newItem.date = date
        newItem.title = title
        newItem.artist = artist
        newItem.albumArt = albumArt
        newItem.story = story
        newItem.image = image.pngData()
        newItem.lyrics = lyrics
        
        saveContent()
    }
    
    func deleteContent(item: Content) {
        self.context.delete(item)
        
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
