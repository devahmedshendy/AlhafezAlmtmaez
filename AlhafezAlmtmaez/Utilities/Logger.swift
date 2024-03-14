//
//  Logger.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import Foundation
import OSLog

// MARK: - Debug Prints

#if DEBUG
@inline(__always) func debugLog(_ error: Error) {
    let e = error as NSError
    logDebug(e.debugDescription)
}

@inline(__always) func debugLog(_ object: Any...) {
    logDebug(object)
}
@inline(__always) func jsonDataLog(_ data: Data?) {
    guard let data = data else { return }

    do {
        if let json = try JSONSerialization.jsonObject(
            with: data,
            options: [.json5Allowed, .fragmentsAllowed]
        ) as? [String : Any] {
            debugLog(json)
        }

    } catch let error as NSError {
        errorLog(error)
    }
}
#else
@inline(__always) func debugLog(_ error: Error) {}
@inline(__always) func debugLog(_ object: Any...) {}
@inline(__always) func jsonDataLog(_ data: Data?) {}
#endif

// MARK: - Error Prints

func errorLog(_ error: Error) {
    let e = error as NSError
    logError(e.debugDescription)
}

func errorLog(_ object: Any...) {
    logError(object)
}

// MARK: - Deinit Prints

#if DEBUG
@inline(__always) func deinitLog(_ class: AnyObject) {
    Logger.`deinit`.debug("\(String(describing: `class`.self))")
}
#else
@inline(__always) func deinitLog(_ class: AnyObject) {}
#endif

// MARK: - Helpers

fileprivate func logDebug(_ object: Any...) {
    Logger.debugLogger.debug("\n\(object)")
}
fileprivate func logError(_ object: Any...) {
    Logger.errorLogger.error("\(object)")
}

// MARK: - Categories

extension Logger {
    private static var mark: String = "👉"
    private static var subsystem = Bundle.main.bundleIdentifier!

    fileprivate static var `deinit` = Logger(
        subsystem: subsystem,
        category: "✌️ deinit"
    )
    fileprivate static var debugLogger = Logger(
        subsystem: subsystem,
        category: "👉 log"
    )
    fileprivate static var errorLogger = Logger(
        subsystem: subsystem,
        category: "🛑 log"
    )
}
