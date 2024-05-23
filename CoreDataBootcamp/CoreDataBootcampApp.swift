//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Kritchanaxt_. on 23/5/2567 BE.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
