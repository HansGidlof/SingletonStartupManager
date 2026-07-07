//
//  SingletonStartupManagerApp.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import AppKit
import SwiftUI

@main
struct SingletonStartupManagerApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(after: .windowArrangement) {
                Button("Visa/Dölj Konsol") {
                    appDelegate.toggleConsole()
                }
                .keyboardShortcut("k", modifiers: [.command, .shift])
            }
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {

    private lazy var consolePanel = ConsolePanel()

    func applicationDidFinishLaunching(_ notification: Notification) {
        Lifecycle.shared.startUp()
        showConsole()
    }

    func showConsole() {
        consolePanel.makeKeyAndOrderFront(nil)
    }

    /// Shows the console panel if it is hidden, or hides it if it is
    /// already visible, so ⇧⌘K / the menu item acts as a toggle.
    func toggleConsole() {
        if consolePanel.isVisible {
            consolePanel.orderOut(nil)
        } else {
            showConsole()
        }
    }
}
