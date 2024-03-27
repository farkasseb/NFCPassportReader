//
//  Logging.swift
//  NFCTest
//
//  Created by Andy Qua on 11/06/2019.
//  Copyright © 2019 Andy Qua. All rights reserved.
//

import Foundation
import OSLog

//func cprint(_: String) {
//    
//}

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
struct Logger {
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
        let msg = message()
        osLogger.log(level: level, "\(msg)")
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


// TODO: Quick log functions - will move this to something better
public enum LogLevel : Int, CaseIterable {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

public class Log {
    public static var logLevel : LogLevel = .info
    public static var storeLogs = false
    public static var logData = [String]()

    public class func verbose( _ msg : @autoclosure () -> String ) {
        log( .verbose, msg )
    }
    public class func debug( _ msg : @autoclosure () -> String ) {
        log( .debug, msg )
    }
    public class func info( _ msg : @autoclosure () -> String ) {
        log( .info, msg )
    }
    public class func warning( _ msg : @autoclosure () -> String ) {
        log( .warning, msg )
    }
    public class func error( _ msg : @autoclosure () -> String ) {
        log( .error, msg )
    }
    
    public class func clearStoredLogs() {
        logData.removeAll()
    }
    
    class func log( _ logLevel : LogLevel, _ msg : () -> String ) {
        if self.logLevel.rawValue <= logLevel.rawValue {
            let message = msg()
            
            if storeLogs {
                logData.append( message )
            }
        }
    }
}
