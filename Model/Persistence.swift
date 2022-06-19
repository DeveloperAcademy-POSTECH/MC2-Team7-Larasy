//
//  Persistence.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/17.
//

import CoreData
//import SwiftUI

// MARK: - CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer

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
}
