//
//  TaskItem.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import SwiftData
import Foundation

@available(iOS 17, *)
@Model
class TaskItem {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var expiresAt: Date?
    
    init(title: String, expiresAt: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
        self.expiresAt = expiresAt
    }
}

