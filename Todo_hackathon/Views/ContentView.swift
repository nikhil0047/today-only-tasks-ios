import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            VStack {

                addTaskSection

                if viewModel.tasks.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.tasks, id: \.id) { task in
                            TaskRowView(task: task) {
                                viewModel.toggleCompletion(task)
                            }
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Today")
        }
    }
}

private extension ContentView {

    var addTaskSection: some View {
        VStack(spacing: 10) {

            HStack {
                TextField("Add task for today", text: $viewModel.newTaskTitle)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    viewModel.addTask()
                }
                .disabled(viewModel.newTaskTitle.isEmpty)
            }

            Toggle("Set expiration time", isOn: $viewModel.setExpiration)

            if viewModel.setExpiration {
                DatePicker(
                    "Expires at",
                    selection: $viewModel.expirationTime,
                    displayedComponents: .hourAndMinute
                )
            }
        }
        .padding()
    }
}

