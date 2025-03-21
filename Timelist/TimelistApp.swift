//
//  TimelistApp.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//

import SwiftUI

@main
struct TimelistApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
