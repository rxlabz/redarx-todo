import 'package:redarx/redarx.dart';
import 'package:todomvc0/model/model.dart';
import 'package:todomvc0/model/todo.dart';

enum RequestType { ADD_TODO, UPDATE_TODO, ARCHIVE, CLEAR_ARCHIVES, TOGGLE_SHOW_COMPLETED }

class AddTodoCommand<T extends TodoModel> implements Command<T> {
  Todo todo;

  AddTodoCommand(Todo this.todo);

  @override
  T exec(T model) {
    model.items.add(todo);
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new AddTodoCommand(todo);
  }
}

class ArchiveCommand<T extends TodoModel> implements Command<T> {
  ArchiveCommand();

  @override
  T exec(T model) {
    model.items = model.items.where((t) => !t.completed).toList();
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new ArchiveCommand();
  }
}

class UpdateTodoCommand<T extends TodoModel> implements Command<T> {
  Todo todo;

  UpdateTodoCommand(Todo this.todo);

  @override
  T exec(T model) {
    var updated = model.items.singleWhere((t) => t.uid == todo.uid);
    final updatedIndex = model.items.indexOf(updated);
    model.items.removeAt(updatedIndex);
    model.items.insert(updatedIndex, todo);
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new UpdateTodoCommand(todo);
  }
}

class ClearArchivesCommand<T extends TodoModel> implements Command<T> {
  ClearArchivesCommand();

  @override
  T exec(T model) {
    model.items = model.items.where((t) => !t.completed).toList();
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new ClearArchivesCommand();
  }
}

class ToggleShowArchivesCommand<T extends TodoModel> implements Command<T> {
  ToggleShowArchivesCommand();

  @override
  T exec(T model) {
    model.showCompleted = !model.showCompleted;
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new ToggleShowArchivesCommand();
  }
}


