//
//  Logging.swift
//  NFCTest
//
//  Created by Andy Qua on 11/06/2019.
//  Copyright © 2019 Andy Qua. All rights reserved.
//

import Foundation
import OSLog

// FACEKOM:: MODIFICATION BEGIN
fileprivate extension os.Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Tag Reader logs
    static let passportoReader = os.Logger(subsystem: subsystem, category: "passportReader")

    /// Tag Reader logs
    static let tagReader = os.Logger(subsystem: subsystem, category: "tagReader")

    /// SecureMessaging logs
    static let secureMessaging = os.Logger(subsystem: subsystem, category: "secureMessaging")

    static let openSSL = os.Logger(subsystem: subsystem, category: "openSSL")

    static let bac = os.Logger(subsystem: subsystem, category: "BAC")
    static let chipAuth = os.Logger(subsystem: subsystem, category: "chipAuthentication")
    static let pace = os.Logger(subsystem: subsystem, category: "PACE")
}

// FACEKOM::Hint: Logger proxy to avoid the rest of the code 
// from unnecessary changes when merging changes back from the original maintainer
public struct Logger {
    public enum Level : Int, CaseIterable {
        case `default` = 0
        case info = 1
        case debug = 2
        case error = 3
        case fault = 4
        fileprivate init(oslogType: OSLogType) {
            self = switch oslogType {
            case .default:
                .default
            case .info:
                .info
            case .debug:
                .debug
            case .error:
                .error
            case .fault:
                .fault
            default:
                .default
            }
        }
    }
    
    public struct Config {
        public typealias CustomLogHandler = (_ level: Level, _ message: () -> String) -> ()
        public enum Mode {
            case osLog
            case custom(CustomLogHandler)
            case noLogging
        }
        public static var mode = Mode.noLogging
    }
    
    private let osLogger: os.Logger
    
    private init(osLogger: os.Logger) {
        self.osLogger = osLogger
    }
    
    static let passportReader = Logger(osLogger: os.Logger.passportoReader)

    static let tagReader = Logger(osLogger: os.Logger.tagReader)

    /// SecureMessaging logs
    static let secureMessaging = Logger(osLogger: os.Logger.secureMessaging)

    static let openSSL = Logger(osLogger: os.Logger.openSSL)

    static let bac = Logger(osLogger: os.Logger.bac)
    static let chipAuth = Logger(osLogger: os.Logger.chipAuth)
    static let pace = Logger(osLogger: os.Logger.pace)
    
    
    func log(_ message: @autoclosure () -> String) {
        log(level: .default, message)
    }
    
    func log(level: OSLogType, _ message: () -> String) {
        switch Self.Config.mode {
        case .osLog:
            let msg = message()
            osLogger.log(level: level, "\(msg)")
        case .custom(let handler):
            handler(Level(oslogType: level), message)
        case .noLogging:
            break
        }
    }

    func trace(_ message: @autoclosure () -> String) {
        log(level: .debug, message)
    }

    func debug(_ message: @autoclosure () -> String) {
        log(level: .debug, message)
    }

    func info(_ message: @autoclosure () -> String) {
        log(level: .info, message)
    }

    func notice(_ message: @autoclosure () -> String) {
        log(level: .default, message)
    }

    func warning(_ message: @autoclosure () -> String) {
        log(level: .error, message)
    }

    func error(_ message: @autoclosure () -> String) {
        log(level: .error, message)
    }

    func critical(_ message: @autoclosure () -> String) {
        log(level: .fault, message)
    }

    func fault(_ message: @autoclosure () -> String) {
        log(level: .fault, message)
    }
}
// FACEKOM:: MODIFICATION END
