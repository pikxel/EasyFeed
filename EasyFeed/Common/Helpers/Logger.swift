//
//  Logger.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import os.log
//import ZNI

// MARK: String Extension
extension String {
    func log(line: Int =  #line, file: String = #file) {
        Log.info(self, line: line, file: file)
    }
}

// MARK: - Date extension
extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }

    static var tomorrow: Date? {
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: 1, to: today)
    }
}

// MARK: - Log Category Type
public enum LogCategoryType: Int {
    case userInterface = 0
    case network
    case push
    case info
    case error
    case debug
    case fault

    var description: String {
        switch self {
        case .userInterface:
            return "UI"
        case .network:
            return "Network"
        case .push:
            return "Push notifications"
        case .info:
            return "Info"
        case .error:
            return "Error"
        case .debug:
            return "Debug"
        case .fault:
            return "Fault"
        }
    }

    var symbol: String {
        switch self {
        case .userInterface:
            return "❕"
        case .network:
            return "💭"
        case .push:
            return "❕"
        case .info:
            return "ℹ️"
        case .error:
            return "❌"
        case .debug:
            return "❕"
        case .fault:
            return "‼️"
        }
    }

    var osLog: OSLog {
        return OSLog(subsystem: Log.subsystem,
                     category: Log.configuration.showSymbols ? self.symbol : self.description)
    }
}

// MARK: - Log Configuration

final class LogConfiguration {
    var showSymbols: Bool = false

    var logEnabled: Bool = false

    var logSharingEnabled: Bool = false

    var logLocationEnabled: Bool = false

    var filePath: URL?

    func addLogSharing(filePath: URL?) -> LogConfiguration {
        logSharingEnabled = true
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "\(Log.subsystem) \(Date().toString()).log"
        self.filePath = filePath ?? paths[0].appendingPathComponent(fileName)
        return self
    }
}

// MARK: - Log Manager
class Log {
    /// Subsystem
    static var subsystem = Bundle.main.bundleIdentifier ?? "-"

    /// Configuration
    static var configuration: LogConfiguration = LogConfiguration()

    static var dateFormat = "yyyy-MM-dd hh:mm:ss"

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    /// Method saves message to file
    ///
    /// - Parameter message: Message
    private class func saveMessageToFile(_ message: String) {
        guard let url = Log.configuration.filePath,
            Log.configuration.logSharingEnabled,
            Log.configuration.logEnabled else { return }

        let message = "\(Date().toString()) \(message)\n"
        if FileManager.default.fileExists(atPath: url.path) {
            if  let fileHandle = try? FileHandle(forWritingTo: url),
                let messageData = message.data(using: .utf8) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(messageData)
                fileHandle.closeFile()
            }
        } else {
            try? message.write(to: url, atomically: true, encoding: .utf8)
        }
    }

    /// Log location
    ///
    /// - Parameters:
    ///   - line: Line number
    ///   - filePath: File path
    /// - Returns: Returns string [File name:line number]
    private class func logLocation(line: Int, filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        let fileName = components.isEmpty ? "" : (components.last ?? "")
        return "[\(fileName):\(line)] "
    }
}

// MARK: - Networking logs
extension Log {
    /// Logs network request
    /// - Parameters:
    ///   - request: Request of type URLRequest
    ///   - includeHeaders: Defines if headers should be included in log. Default to false
    static func log(request: URLRequest, includeHeaders: Bool = false) {
        let jsonBody = request.httpBody != nil ? String(data: request.httpBody!, encoding: .utf8) : nil
        var message = "\n[REQUEST]: \(request.url?.absoluteString ?? "-")"
        message.append("\n[METHOD]: \(request.httpMethod ?? "-")")
        if includeHeaders {
            message.append("\n[HTTP HEADERS]: \(request.allHTTPHeaderFields?.description ?? "-")")
        }

        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB, .useKB]
        bcf.countStyle = .file
        let requestSizeString = bcf.string(fromByteCount: Int64(request.httpBody?.count ?? 0))

        message.append("\n[BODY]: \(requestSizeString) \(jsonBody ?? "-")")

//        message.append(request.curlString)
        self.log(message: message,
                 logCategory: LogCategoryType.network,
                 type: .info)
    }
/*
    static func requestLog(_ params: ZNIRequest.Params, line: Int = #line, file: String = #file) {
        var jsonBody: String?
        if  let body = params.jsonBody,
            let json = try? JSONSerialization.data(withJSONObject: body,
                                                   options: JSONSerialization.WritingOptions.prettyPrinted) {
            jsonBody = String(data: json, encoding: .utf8)
        }

        let message =   """
        Sending request...
        [URL]: \(params.url?.absoluteString ?? "-")
        [METHOD]: \(params.httpMethod)
        [HTTP HEADERS]: \(params.httpHeaders.description)
        [BODY]: \(jsonBody ?? "-")
        """
        self.log(message: logLocation(line: line, filePath: file) + message,
                 logCategory: LogCategoryType.network,
                 type: .info)
    }
    */

    /// Logs a network response
    /// - Parameters:
    ///   - response: Network response of type HTTPURLResponse
    ///   - responseData: Response data
    ///   - includeHeaders: Defines if headers should be included in log message. Default to false
    static func log(response: HTTPURLResponse?, responseData: Data?, includeHeaders: Bool = false) {
        var message =   """
        \n[URL RESPONSE]: \(response?.url?.absoluteString ?? "-")
        [RESPONSE CODE]: \(response?.statusCode ?? 0)
        """
        if let headers = response?.allHeaderFields as? [String: Any], includeHeaders {
            let headersString = headers.description
            message.append("\n[RESPONSE HEADERS]: \(headersString)")
        }

        if let data = responseData {
            let dataString = String(data: data, encoding: .utf8)
            message.append("\n[RESPONSE DATA]: \(dataString ?? "Empty")")
        }
        self.log(message: message,
                 logCategory: LogCategoryType.network,
                 type: .info)
    }
/*
    static func responseLog(_ response: ZNIResponse, responseData: Data, line: Int = #line, file: String = #file) {
        let message =   """
        Received response:
        [URL RESPONSE]: \(response.httpResponse?.url?.absoluteString ?? "-")
        [RESPONSE CODE]: \(response.statusCode)
        [RESPONSE HEADERS]: \(response.httpResponse?.allHeaderFields.description ?? "-" )
        [RESPONSE DATA]: \(String(data: responseData, encoding: .utf8) ?? "-")
        """
        self.log(message: logLocation(line: line, filePath: file) + message,
                 logCategory: LogCategoryType.network,
                 type: .info)
    }*/
}

// MARK: - Logs
extension Log {
    /// Logs an error message
    /// - Parameters:
    ///   - message: Error message to be logged
    ///   - line: Location - line
    ///   - file: Location - file
    static func error(_ message: String?, line: Int = #line, file: String = #file) {
        self.log(message: message,
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: LogCategoryType.error,
                 type: .error)
    }

    /// Logs an error. Errors localized description will be logged
    /// - Parameters:
    ///   - error: error conforming to protocol Error
    ///   - line: Location - line
    ///   - file: Location - file
    static func error(_ error: Error?, line: Int = #line, file: String = #file) {
        self.log(message: error?.localizedDescription ?? "",
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: LogCategoryType.error,
                 type: .error)
    }

    /// Logs a message with Info category
    /// - Parameters:
    ///   - message: Message to be logged
    ///   - line: Location - line
    ///   - file: Location - file
    class func info(_ message: String?, line: Int = #line, file: String = #file) {
        self.log(message: message,
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: LogCategoryType.info,
                 type: .info)
    }

    /// Logs a message with debug category
    /// - Parameters:
    ///   - message: Message to be logged
    ///   - line: Location - line
    ///   - file: Location - file
    static func debug(_ message: String?, line: Int = #line, file: String = #file) {
        self.log(message: message,
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: LogCategoryType.debug,
                 type: .debug)
    }

    /// Logs a message with fault category
    /// - Parameters:
    ///   - message: Message to be logged
    ///   - line: Location - line
    ///   - file: Location - file
    static func fault(_ message: String?, line: Int = #line, file: String = #file) {
        self.log(message: message,
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: LogCategoryType.fault,
                 type: .fault)
    }

    /// Main logging function. Logs a message to os_log and saves a message to log file if parameter filePath
    /// is specified in LogConfiguration
    /// - Parameters:
    ///   - message: Message to be logged
    ///   - category: Message category
    ///   - type: os_log message type
    ///   - line: Location - line
    ///   - file: Location - file
    static func log(message: String?,
                    category: LogCategoryType,
                    type: OSLogType,
                    line: Int = #line,
                    file: String = #file) {
        self.log(message: message,
                 logLocation: logLocation(line: line, filePath: file),
                 logCategory: category,
                 type: type)
    }

    private class func log(message: String?, logLocation: String = "", logCategory: LogCategoryType, type: OSLogType) {
        guard let message = message, self.configuration.logEnabled else { return }
        #if !RELEASE
        let location = self.configuration.logLocationEnabled ? (logLocation + " ") : ""
        os_log("%@", log: logCategory.osLog, type: type, "\(location)\(message)")
        if self.configuration.filePath != nil {
            self.saveMessageToFile( "\(logLocation) \(message)")
        }
        #endif
    }
}

// MARK: - Signpost log (Performance log)
@available(iOS 12.0, *)
extension Log {
    static func signpostLog(name: StaticString,
                            category: LogCategoryType,
                            messageStart: String?,
                            messageEnd: String?,
                            block: @escaping ((_ completionHandler: () -> Void) -> Void) ) {
        let log = category.osLog
        let signpostID = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: name, signpostID: signpostID, "%@", messageStart ?? "")
        block {
            os_signpost(.end, log: log, name: name, signpostID: signpostID, "%@", messageEnd ?? "")
        }
    }

    static func singpostStart(message: String?, singpostObject: SignpostObject) {
        os_signpost(.begin,
                    log: singpostObject.log,
                    name: singpostObject.name,
                    signpostID: singpostObject.signpostId,
                    "%@",
                    message ?? "")
    }

    static func singpostEnd(message: String?, singpostObject: SignpostObject ) {
        os_signpost(.end,
                    log: singpostObject.log,
                    name: singpostObject.name,
                    signpostID: singpostObject.signpostId,
                    "%@",
                    message ?? "")
    }
}

// MARK: - Signpost Object
@available(iOS 12.0, *)
class SignpostObject {
    var name: StaticString
    var category: LogCategoryType
    var log: OSLog
    var signpostId: OSSignpostID

    public init(name: StaticString, category: LogCategoryType) {
        self.name = name
        self.category = category
        self.log = category.osLog
        self.signpostId = OSSignpostID(log: log)
    }
}
