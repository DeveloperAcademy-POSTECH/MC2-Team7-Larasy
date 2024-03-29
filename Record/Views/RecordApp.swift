//
//  RecorderApp.swift
//  Recorder
//
//  Created by 최윤석 on 2022/06/09.
//

import SwiftUI

@main
struct RecordApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            OnboardingStartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
