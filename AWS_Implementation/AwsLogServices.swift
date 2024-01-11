//
//  LogServices.swift
//  AWS_Implementation
//
//  Created by Dev on 1/11/24.
//

import Foundation
import AWSCore
import AWSLogs

/// This can me used to categories log and easy to analyze this
enum LogLevel: String {
    case critical,
         warning,
         normal,
         info
}

class AwsLogServices {
    
    static let shared = AwsLogServices()
    
    private let AWS_KEY = "default"
        
    private init() {
        let credentialsProvider = AWSStaticCredentialsProvider(
            accessKey: AWSCredentials.accessKey,
            secretKey: AWSCredentials.secretKey
        )

        let configuration = AWSServiceConfiguration(
            region: AWSCredentials.region,
            credentialsProvider: credentialsProvider
        )

        AWSLogs.register(with: configuration!, forKey: AWS_KEY)
    }
    
    private func logEventToCloudWatch(logGroupName: String, logStreamName: String, logMessage: String, logData: [AnyHashable: Any]) {
        var logsEvent: [AWSLogsInputLogEvent] = []
        
        if let event = try? AWSLogsInputLogEvent(dictionary: logData, error: ()) {
            event.message = logMessage
            event.timestamp = .init(value: Date().timeIntervalSince1970 * 1000)
            logsEvent.append(event)
        }


        let putLogEventRequest = LogEvent(logGroupName: logGroupName, logStreamName: logStreamName, logevent: logsEvent)

        AWSLogs(forKey: AWS_KEY).putLogEvents(putLogEventRequest).continueWith { task -> Any? in
            if let error = task.error {
                // Error handling here
                print("Error logging to CloudWatch: \(error)")
            }
            return nil
        }
    }
    
    
    /// Used to log event anywhere from app
    ///
    /// Enhance this function by incorporating logic to allow for the selection of logGroupName and logStreamName
    /// - Parameters:
    ///   - level: Logging level is used to categories. it will append the start of message
    ///   - message: The actual message that goint to log
    ///   - data: Append any data or property with log event
    func log(level: LogLevel, message: String, data: [String: Any] = [:]) {
        var logMessage = "\(level.rawValue) | \(message)"
        // Add Logic select relevent group name and stream
        // can use something like swift here
        logEventToCloudWatch(logGroupName: "group_name_from_cloudwatch_panel", logStreamName: "stream_name_from_group", logMessage: logMessage, logData: data)
    }
    
}
