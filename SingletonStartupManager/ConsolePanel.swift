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
        titlebarAppearsTransparent = true
        level = .floating
        hidesOnDeactivate = false
        isMovableByWindowBackground = true
        animationBehavior = .utilityWindow
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        title = "Konsol"
        isFloatingPanel = true
        becomesKeyOnlyIfNeeded = true
        isReleasedWhenClosed = false
        isRestorable = false

        contentView = NSHostingView(rootView: ConsoleWindow())

        // Restore the saved position if there is one; otherwise default to the
        // bottom-left corner. Moving the panel auto-saves its new position.
        let autosaveName = NSWindow.FrameAutosaveName("ConsolePanel")
        let hasSavedPosition = setFrameUsingName(autosaveName)
        setFrameAutosaveName(autosaveName)
        if !hasSavedPosition {
            moveToBottomLeftCorner()
        }
    }

    override func performClose(_ sender: Any?) {
        orderOut(sender)
    }

    /// Positions the panel in the bottom-left corner of the active screen,
    /// respecting the Dock and menu bar via `visibleFrame`.
    private func moveToBottomLeftCorner() {
        guard let visible = (screen ?? NSScreen.main)?.visibleFrame else { return }
        let margin: CGFloat = 20
        let origin = NSPoint(x: visible.minX + margin, y: visible.minY + margin)
        setFrameOrigin(origin)
    }
}
