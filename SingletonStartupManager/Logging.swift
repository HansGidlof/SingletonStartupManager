//
//  Logging.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-24.
//

import Foundation

// MARK: - LogLevel

enum LogLevel: String {
    case debug
    case info
    case warning
    case error
}

// MARK: - Logging

/// App-wide logging singleton.
final class Logging {

    // MARK: - Shared Instance

    /// The app-wide instance.
    static let shared = Logging()

    // MARK: - Init

    private init() {
    }

    // MARK: - Logging

    /// Logs a message at the given level.
    func log(_ message: String, level: LogLevel = .info) {
        print("[\(level.rawValue.uppercased())] \(message)")
    }

    func debug(_ message: String) { log(message, level: .debug) }
    func info(_ message: String) { log(message, level: .info) }
    func warning(_ message: String) { log(message, level: .warning) }
    func error(_ message: String) { log(message, level: .error) }
}
