//
//  LogEvent.swift
//  AWS_Implementation
//
//  Created by Dev on 1/11/24.
//

import Foundation
import AWSLogs

class LogEvent: AWSLogsPutLogEventsRequest {
    init(logGroupName: String, logStreamName: String, logevent: [AWSLogsInputLogEvent]) {
        super.init()
        super.logGroupName = logGroupName
        super.logStreamName = logStreamName
        super.logEvents = logevent
    }
    
    required init!(coder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
}
