//
//  Persistence.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/17.
//

import CoreData


// MARK: - CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Content(context: viewContext)
            newItem.lylic = ""
            newItem.artist = ""
            newItem.albumArt = ""
            newItem.story = ""
            newItem.id = UUID()
            newItem.image = ""
            newItem.title = ""
            newItem.date = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // TODO: Error 처리
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Recorder")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO: Error 처리
                /* Error 발생 경우
                    - 파일을 만들 수 없거나, 쓰기를 허용하지 않았을 때
                    - 장치의 공간이 부족할 때 */
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
