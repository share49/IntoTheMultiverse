//
//  Logger.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/20/22.
//

import Foundation
import OSLog

protocol LogHandler {
    func debug(_ message: String)
    func error(_ message: String)
}

/// App Logger ("Multiverse" Logger)
struct MLogger: LogHandler {
    
    // MARK: - Properties
    
    let logger = Logger(subsystem: "com.hoowie.IntoTheMultiverse", category: "Logger")
    
    // MARK: - Methods
    
    func debug(_ message: String) {
        logger.debug("\(message)")
    }
    
    func error(_ message: String) {
        logger.error("\(message)")
    }
}
