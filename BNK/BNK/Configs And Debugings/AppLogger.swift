//
//  AppLogger.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARN"
    case error = "ERROR"
}

enum AppLogger {
    static func log(_ message: String, level: LogLevel = .info, category: String = "App") {
        #if DEBUG
        print("[\(level.rawValue)][\(category)] \(message)")
        #else
        switch level {
        case .warning, .error:
            print("[\(level.rawValue)][\(category)] \(message)")
        default:
            break
        }
        #endif
    }
}

