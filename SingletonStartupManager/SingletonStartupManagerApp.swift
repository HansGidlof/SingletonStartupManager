//
//  SingletonStartupManagerApp.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import SwiftUI

@main
struct SingletonStartupManagerApp: App {

    private let consolePanel = ConsolePanel()

    init() {
        Lifecycle.shared.startUp()
        consolePanel.orderFront(nil)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
