# Task App

This is a Task app built with Flutter, following the principles of Clean Architecture. The app uses the BLoC (Business Logic Component) pattern to separate concerns and achieve independence between different layers of the application.

## Architecture Overview

The app architecture follows the Clean Architecture principles, as advocated by Uncle Bob. The layered "onion" diagram represents the dependency flow between different layers:

- **Entities**: The core business logic entities that represent the application's data and behavior. They are independent and do not depend on any other layer.
- **Use Cases**: The application-specific use cases that define the operations or actions the app can perform. They depend only on the Entities layer.
- **Repositories**: The interfaces defining the contract for data operations. They are implemented by concrete data sources (e.g., API, local database). Use Cases depend on Repositories, but Repositories are independent of other layers.
- **Data Sources**: The concrete implementations of Repositories, responsible for handling data operations, such as fetching data from an API or a local database. They depend on external data providers and libraries.
- **Presentation**: The UI layer responsible for displaying data and interacting with the user. It depends on Use Cases to perform the business logic operations and retrieve data.

## Use Cases

The app defines the following use cases:

- `getAllTasks()`: Retrieves a list of all tasks. Returns `Either<Failure, List<TaskModel>>`, where `Failure` represents an error and `TaskModel` represents the task data.
- `addTask(TaskModel task)`: Adds a new task. Returns `Either<Failure, TaskModel>` representing the added task or a failure.
- `updateTask(TaskModel task)`: Updates an existing task. Returns `Either<Failure, TaskModel>` representing the updated task or a failure.
- `deleteAllTasks()`: Deletes all tasks. Returns `Either<Failure, Ok>` indicating success or failure.
- `deleteTask(String id)`: Deletes a specific task identified by its `id`. Returns `Either<Failure, Ok>` indicating success or failure.
- `saveName(String id)`: Saves the name associated with a task identified by its `id`. Returns `Either<Failure, Ok>` indicating success or failure.
- `getName()`: Retrieves the name associated with a task. Returns `Either<Failure, String>` representing the name or a failure.
- `editName(String id)`: Edits the name associated with a task identified by its `id`. Returns `Either<Failure, Ok>` indicating success or failure.
- `removeUsername()`: Removes the username. Returns `Either<Failure, Ok>` indicating success or failure.

## Getting Started
