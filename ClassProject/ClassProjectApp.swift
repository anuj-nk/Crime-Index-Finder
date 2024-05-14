//
//  ClassProjectApp.swift
//  ClassProject
//
//  Created by Anuj Kamasamudram on 3/19/24.
//

import SwiftUI

@main
struct ClassProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
