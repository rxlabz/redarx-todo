import 'package:redarx/redarx.dart';
import 'package:todo_redarx/model/model.dart';
import 'package:todo_redarx/model/todo.dart';

enum RequestType {
  ADD_TODO,
  UPDATE_TODO,
  ARCHIVE,
  CLEAR_ARCHIVES,
  TOGGLE_SHOW_COMPLETED
}

class AddTodoCommand<T extends TodoModel> implements Command<T> {
  Todo todo;

  AddTodoCommand(this.todo);

  @override
  T exec(T model) => model..items.add(todo);

  static CommandBuilder constructor() {
    return (Todo todo) => new AddTodoCommand(todo);
  }
}

class ArchiveCommand<T extends TodoModel> implements Command<T> {
  @override
  T exec(T model) =>
      model..items = model.items.where((t) => !t.completed).toList();

  static CommandBuilder constructor() {
    return (t) => new ArchiveCommand();
  }
}

class UpdateTodoCommand<T extends TodoModel> implements Command<T> {
  Todo todo;

  UpdateTodoCommand(this.todo);

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
  @override
  T exec(T model) =>
      model..items = model.items.where((t) => !t.completed).toList();

  static CommandBuilder constructor() {
    return (t) => new ClearArchivesCommand();
  }
}

class ToggleShowArchivesCommand<T extends TodoModel> implements Command<T> {
  @override
  T exec(T model) => model..showCompleted = !model.showCompleted;

  static CommandBuilder constructor() {
    return (t) => new ToggleShowArchivesCommand();
  }
}
