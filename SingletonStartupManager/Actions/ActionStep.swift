//
//  ActionStep.swift
//  SingletonStartupManager
//
//  Created by Hans Gidlof on 2026-07-09.
//

import Foundation

// MARK: - StepError

/// A simple error a step can throw. Used for mocking failures in the flow.
enum StepError: LocalizedError {
    case failed(String)

    var errorDescription: String? {
        switch self {
        case .failed(let message): return message
        }
    }
}

// MARK: - ActionStep

/// A single sub-step within a `StartupAction` (e.g. "read data").
/// Steps run in order and are what the console surfaces one at a time.
struct ActionStep {
    private let work: () throws -> Void
    private(set) var tearDown: () throws -> Void

    let name: String

    /// Whether the step ran to completion without throwing.
    /// Stays `false` if `run()` errors out.
    private(set) var completed = false

    init(_ name: String, _ work: @escaping () throws -> Void, _ tearDown: @escaping () -> Void = {}) {
        self.name = name
        self.work = work
        self.tearDown = tearDown
    }

    mutating func run() throws {
        try work()
        completed = true
    }
    
    
    func tear() throws {
        try tearDown()
    }
}
