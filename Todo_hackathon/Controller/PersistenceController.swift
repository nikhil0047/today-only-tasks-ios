//
//  PersistenceController.swift
//  Todo_hackathon
//
//  Created by Nikhil Shinde on 19/02/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TodayTasks")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data load error: \(error)")
            }
        }
    }
}

