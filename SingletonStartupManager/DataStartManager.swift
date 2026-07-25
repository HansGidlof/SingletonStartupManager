//
//  DataStartManager.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-19.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class sprakManager {
    var todoList: [LanguageModel] = []
    var error: Error? = nil

    enum OtherErrors: Error {
        case nilContext
    }

    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil
}
