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
