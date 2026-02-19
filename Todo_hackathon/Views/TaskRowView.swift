//
//  TaskRowView.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import SwiftUI

struct TaskRowView: View {

    let task: TaskEntity
    var onToggle: () -> Void

    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
            }

            VStack(alignment: .leading) {
                Text(task.title ?? "")
                    .strikethrough(task.isCompleted)
                    .opacity(task.isCompleted ? 0.6 : 1)

                if let expiry = task.expiresAt {
                    Text("Expires \(expiry.formatted(date: .omitted, time: .shortened))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .animation(.easeInOut, value: task.isCompleted)
    }
}
