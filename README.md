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
To run this project locally, follow these steps:

1. Ensure you have Flutter installed on your development machine.
2. Clone this repository .
3. Open the project in your preferred IDE.
4. Run `flutter pub get` to fetch the project dependencies.
5. Connect a device or start an emulator.
6. Run `flutter run` to launch the app.

## Dependencies

This project relies on the following dependencies:

- [cupertino_icons](https://pub.dev/packages/cupertino_icons): Flutter's official set of Cupertino icons.
- [dartz](https://pub.dev/packages/dartz): A functional programming library for Dart, providing tools for error handling and immutable data structures.
- [equatable](https://pub.dev/packages/equatable): Provides equality comparisons for Dart objects.
- [internet_connection_checker](https://pub.dev/packages/internet_connection_checker): A plugin to check the internet connection status in Flutter apps.
- [get_it](https://pub.dev/packages/get_it): A simple service locator for Dart and Flutter projects.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): A state management library for Flutter that implements the BLoC pattern.
- [sqflite](https://pub.dev/packages/sqflite): Flutter plugin for SQLite, a self-contained, serverless, zero-configuration, transactional SQL database engine.
- [path](https://pub.dev/packages/path): A library to handle file and directory paths in Dart.
- [uuid](https://pub.dev/packages/uuid): A package for creating and working with RFC4122 UUIDs.
- [dotted_border](https://pub.dev/packages/dotted_border): A Flutter package to create a dotted border around widgets.
- [intl](https://pub.dev/packages/intl): Flutter package for internationalization support.
- [flutter_week_view](https://pub.dev/packages/flutter_week_view): A week view widget for Flutter.
- [flutter_svg](https://pub.dev/packages/flutter_svg): A Flutter SVG rendering library.
- [shared_preferences](https://pub.dev/packages/shared_preferences): Flutter plugin for reading and writing simple key-value pairs.


