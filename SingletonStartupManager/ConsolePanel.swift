//
//  ConsolePanel.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-06-03.
//

import AppKit
import SwiftUI

final class ConsolePanel: NSPanel {

    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 240),
            styleMask: [.titled, .closable, .miniaturizable, .utilityWindow, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        title = "Konsol"
        isFloatingPanel = true
        becomesKeyOnlyIfNeeded = true
        isReleasedWhenClosed = false
        isRestorable = false
        center()

        contentView = NSHostingView(rootView: ConsoleWindow())
    }
}
