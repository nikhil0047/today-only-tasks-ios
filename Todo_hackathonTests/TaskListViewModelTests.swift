//
//  TaskListViewModelTests.swift
//  Todo_hackathonTests
//
//  Created by Nikhil Shinde on 19/02/26.
//

import XCTest
@testable import Todo_hackathon
import CoreData

@MainActor
final class TaskListViewModelTests: XCTestCase {
    
    // MARK: Helper
    func makeInMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "TodayTasks")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }

        return container
    }


    var viewModel: TaskListViewModel!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        let container = makeInMemoryContainer()
        context = container.viewContext

        viewModel = TaskListViewModel(context: context)
    }
    
    func testFilterShowsOnlyTodayTasks() {
        let todayTask = TaskEntity(context: context)
        todayTask.createdAt = Date()

        let yesterdayTask = TaskEntity(context: context)
        yesterdayTask.createdAt = Calendar.current.date(byAdding: .day, value: -1, to: Date())

        let result = viewModel.filterTodayTasks([todayTask, yesterdayTask])

        XCTAssertEqual(result.count, 1)
    }

    func testExpiredTasksAreFilteredOut() {
        let task = TaskEntity(context: context)
        task.createdAt = Date()
        task.expiresAt = Calendar.current.date(byAdding: .minute, value: -10, to: Date())

        let result = viewModel.filterTodayTasks([task])

        XCTAssertTrue(result.isEmpty)
    }

    func testTaskWithFutureExpirationIsVisible() {
        let task = TaskEntity(context: context)
        task.createdAt = Date()
        task.expiresAt = Calendar.current.date(byAdding: .hour, value: 2, to: Date())

        let result = viewModel.filterTodayTasks([task])

        XCTAssertEqual(result.count, 1)
    }

    func testToggleCompletionUpdatesState() {
        let task = TaskEntity(context: context)
        task.isCompleted = false

        viewModel.toggleCompletion(task)

        XCTAssertTrue(task.isCompleted)
    }

    func testAddTaskCreatesTask() {
        viewModel.newTaskTitle = "Test Task"
        viewModel.addTask()

        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let tasks = try? context.fetch(request)

        XCTAssertEqual(tasks?.count, 1)
        XCTAssertEqual(tasks?.first?.title, "Test Task")
    }

}

