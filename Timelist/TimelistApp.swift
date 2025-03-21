//
//  TimelistApp.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//

import SwiftUI

@main
struct TimelistApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {

            EmptyView()
        }
    }
}
