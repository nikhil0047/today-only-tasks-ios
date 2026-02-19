//
//  TaskListViewModel.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import Foundation
import CoreData
import SwiftUI
import UIKit
import Combine

@MainActor
class TaskListViewModel: ObservableObject {

    @Published var tasks: [TaskEntity] = []
    @Published var newTaskTitle = ""
    @Published var setExpiration = false
    @Published var expirationTime = Date()

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext? = nil) {
        self.context = context ?? PersistenceController.shared.container.viewContext
        fetchTasks()
    }

    // MARK: Fetch
    func fetchTasks() {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            tasks = filterTodayTasks(result)
        } catch {
            print("Fetch error:", error)
        }
    }

    // MARK: Filter Today Tasks
    func filterTodayTasks(
        _ items: [TaskEntity],
        now: Date = Date()
    ) -> [TaskEntity] {
        
        let startOfToday = Calendar.current.startOfDay(for: now)

        return items.filter { task in
            guard let created = task.createdAt else { return false }

            let isToday = created >= startOfToday
            let notExpired = task.expiresAt == nil || task.expiresAt! > now

            return isToday && notExpired
        }
        .sorted {
            ($0.createdAt ?? .distantPast) < ($1.createdAt ?? .distantPast)
        }
    }


    // MARK: Add Task
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }

        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = newTaskTitle
        task.isCompleted = false
        task.createdAt = Date()

        if setExpiration {
            task.expiresAt = Calendar.current.date(
                bySettingHour: Calendar.current.component(.hour, from: expirationTime),
                minute: Calendar.current.component(.minute, from: expirationTime),
                second: 0,
                of: Date()
            )
        }

        saveContext()
        resetInputs()
        fetchTasks()
    }

    // MARK: Toggle
    func toggleCompletion(_ task: TaskEntity) {
        task.isCompleted.toggle()
        triggerHaptic()
        saveContext()
        fetchTasks()
    }

    // MARK: Delete
    func delete(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(context.delete)
        saveContext()
        fetchTasks()
    }

    // MARK: Helpers
    private func saveContext() {
        try? context.save()
    }

    private func resetInputs() {
        newTaskTitle = ""
        setExpiration = false
    }

    private func triggerHaptic() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

