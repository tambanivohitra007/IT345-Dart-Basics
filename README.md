# Dart Programming Exercise: Personal Task Manager CLI Application (In-Memory Storage)

## **Objective**

Create a simple Command-Line Interface (CLI) application in Dart that allows users to manage their personal tasks. The application should support adding, viewing, updating, and deleting tasks, all stored in-memory.

## **Estimated Time**

2 Hours

## **Prerequisites**

- Basic understanding of Dart syntax and programming constructs
- Familiarity with Dart’s standard libraries for I/O operations
- Knowledge of data structures like Lists and Maps

## **Exercise Breakdown**

### **Part 1: Setup and Initialization (15 minutes)**

1. **Project Setup**
   - Initialize a new Dart project.
   - Create a `main.dart` file to serve as the entry point.

2. **Data Structure**
   - Decide on an appropriate data structure to store tasks (e.g., List of Maps or creating a `Task` class).

### **Part 2: Core Functionalities (90 minutes)**

1. **Add a Task (20 minutes)**
   - Prompt the user to enter task details:
     - **Title**
     - **Description**
     - **Due Date**
     - **Status** (e.g., Pending, In Progress, Completed)
   - Validate user input.
   - Store the task in the chosen in-memory data structure.

2. **View All Tasks (20 minutes)**
   - Display a list of all tasks with their details.
   - Format the output for readability (e.g., numbered list).

3. **Update a Task (20 minutes)**
   - Allow the user to select a task by its number or ID.
   - Provide options to update any of the task’s attributes.
   - Ensure updates are reflected in the data structure.

4. **Delete a Task (15 minutes)**
   - Enable the user to remove a task by selecting its number or ID.
   - Confirm deletion before removing.

5. **Search/Filter Tasks (15 minutes)**
   - Implement functionality to search tasks by title or filter by status.
   - Display matching tasks.

### **Part 3: User Interface and Experience (20 minutes)**

1. **Menu Navigation**
   - Present a menu to the user with options:
     - Add Task
     - View Tasks
     - Update Task
     - Delete Task
     - Search/Filter Tasks
     - Exit

2. **Input Handling**
   - Handle invalid inputs gracefully.
   - Allow users to return to the main menu after completing an action.

### **Part 4: Optional Enhancements (If time permits)**

- **Sorting Tasks**
  - Allow sorting tasks based on due date or status.

- **Colorful Output**
  - Use packages like `ansicolor` to enhance CLI aesthetics.

---

## **Guidelines**

- **Code Organization**
  - Modularize code using functions or classes where appropriate.

- **Error Handling**
  - Anticipate and handle possible runtime errors (e.g., invalid input formats).

- **Documentation**
  - Comment your code for clarity.
  - Provide a brief README on how to run the application.

---

## **Submission**

- Submit the complete Dart project folder, including all source files.

---

## **Assessment Criteria**

- **Functionality**: All required features are implemented and work as expected.
- **Code Quality**: Code is clean, well-organized, and follows Dart best practices.
- **User Experience**: The CLI is user-friendly and handles inputs gracefully.
- **Creativity**: Implementation of optional features or unique enhancements.

---

## **Hints and Resources**

- **Dart Documentation**: [https://dart.dev/guides](https://dart.dev/guides)
- **Handling User Input**: Use `dart:io` library’s `stdin.readLineSync()` for input.
- **CLI Packages**: Consider using packages like `args` for parsing command-line arguments if expanding functionality.

---

## **Example Starter Code**

```dart
import 'dart:io';

class Task {
  int id;
  String title;
  String description;
  String dueDate;
  String status;

  Task(this.id, this.title, this.description, this.dueDate, this.status);
}

List<Task> tasks = [];
int taskIdCounter = 1;

void main() {
  while (true) {
    print('\n--- Personal Task Manager ---');
    print('1. Add Task');
    print('2. View Tasks');
    print('3. Update Task');
    print('4. Delete Task');
    print('5. Search/Filter Tasks');
    print('6. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addTask();
        break;
      case '2':
        viewTasks();
        break;
      case '3':
        updateTask();
        break;
      case '4':
        deleteTask();
        break;
      case '5':
        searchTasks();
        break;
      case '6':
        print('Exiting... Goodbye!');
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void addTask() {
  stdout.write('Enter title: ');
  String? title = stdin.readLineSync();
  stdout.write('Enter description: ');
  String? description = stdin.readLineSync();
  stdout.write('Enter due date (YYYY-MM-DD): ');
  String? dueDate = stdin.readLineSync();
  stdout.write('Enter status (Pending/In Progress/Completed): ');
  String? status = stdin.readLineSync();

  if (title != null && title.isNotEmpty &&
      description != null && description.isNotEmpty &&
      dueDate != null && dueDate.isNotEmpty &&
      status != null && status.isNotEmpty) {
    tasks.add(Task(taskIdCounter++, title, description, dueDate, status));
    print('Task added successfully!');
  } else {
    print('Invalid input. Task not added.');
  }
}

void viewTasks() {
  if (tasks.isEmpty) {
    print('No tasks available.');
    return;
  }
  print('\n--- All Tasks ---');
  for (var task in tasks) {
    print('\nID: ${task.id}');
    print('Title: ${task.title}');
    print('Description: ${task.description}');
    print('Due Date: ${task.dueDate}');
    print('Status: ${task.status}');
  }
}

void updateTask() {
  stdout.write('Enter the ID of the task to update: ');
  String? input = stdin.readLineSync();
  int? id = int.tryParse(input ?? '');
  if (id == null) {
    print('Invalid ID.');
    return;
  }

  var task = tasks.firstWhere((t) => t.id == id, orElse: () => null);
  if (task == null) {
    print('Task not found.');
    return;
  }

  stdout.write('Enter new title (leave blank to keep "${task.title}"): ');
  String? title = stdin.readLineSync();
  if (title != null && title.isNotEmpty) {
    task.title = title;
  }

  stdout.write('Enter new description (leave blank to keep "${task.description}"): ');
  String? description = stdin.readLineSync();
  if (description != null && description.isNotEmpty) {
    task.description = description;
  }

  stdout.write('Enter new due date (YYYY-MM-DD) (leave blank to keep "${task.dueDate}"): ');
  String? dueDate = stdin.readLineSync();
  if (dueDate != null && dueDate.isNotEmpty) {
    task.dueDate = dueDate;
  }

  stdout.write('Enter new status (Pending/In Progress/Completed) (leave blank to keep "${task.status}"): ');
  String? status = stdin.readLineSync();
  if (status != null && status.isNotEmpty) {
    task.status = status;
  }

  print('Task updated successfully!');
}

void deleteTask() {
  stdout.write('Enter the ID of the task to delete: ');
  String? input = stdin.readLineSync();
  int? id = int.tryParse(input ?? '');
  if (id == null) {
    print('Invalid ID.');
    return;
  }

  var task = tasks.firstWhere((t) => t.id == id, orElse: () => null);
  if (task == null) {
    print('Task not found.');
    return;
  }

  stdout.write('Are you sure you want to delete the task "${task.title}"? (y/n): ');
  String? confirmation = stdin.readLineSync();
  if (confirmation?.toLowerCase() == 'y') {
    tasks.remove(task);
    print('Task deleted successfully!');
  } else {
    print('Deletion canceled.');
  }
}

void searchTasks() {
  stdout.write('Search by title or filter by status? (title/status): ');
  String? option = stdin.readLineSync();

  if (option == null) {
    print('Invalid option.');
    return;
  }

  if (option.toLowerCase() == 'title') {
    stdout.write('Enter title to search: ');
    String? title = stdin.readLineSync();
    if (title == null || title.isEmpty) {
      print('Invalid title.');
      return;
    }
    var results = tasks.where((t) => t.title.toLowerCase().contains(title.toLowerCase())).toList();
    if (results.isEmpty) {
      print('No tasks found with the title containing "$title".');
    } else {
      print('\n--- Search Results ---');
      for (var task in results) {
        print('\nID: ${task.id}');
        print('Title: ${task.title}');
        print('Description: ${task.description}');
        print('Due Date: ${task.dueDate}');
        print('Status: ${task.status}');
      }
    }
  } else if (option.toLowerCase() == 'status') {
    stdout.write('Enter status to filter (Pending/In Progress/Completed): ');
    String? status = stdin.readLineSync();
    if (status == null || status.isEmpty) {
      print('Invalid status.');
      return;
    }
    var results = tasks.where((t) => t.status.toLowerCase() == status.toLowerCase()).toList();
    if (results.isEmpty) {
      print('No tasks found with status "$status".');
    } else {
      print('\n--- Filtered Tasks ---');
      for (var task in results) {
        print('\nID: ${task.id}');
        print('Title: ${task.title}');
        print('Description: ${task.description}');
        print('Due Date: ${task.dueDate}');
        print('Status: ${task.status}');
      }
    }
  } else {
    print('Invalid option.');
  }
}
