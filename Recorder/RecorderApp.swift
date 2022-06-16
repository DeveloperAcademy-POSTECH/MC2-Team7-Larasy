//
//  RecorderApp.swift
//  Recorder
//
//  Created by 최윤석 on 2022/06/09.
//

import SwiftUI

@main
struct RecorderApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
