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

class AddTodoCommand extends Command<TodoModel> {
  Todo todo;

  AddTodoCommand(this.todo);

  @override
  TodoModel exec(TodoModel model) => model..items.add(todo);

  static CommandBuilder constructor() {
    return (Todo todo) => new AddTodoCommand(todo);
  }
}

class ArchiveCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) =>
      model..items = model.items.where((t) => !t.completed).toList();

  static CommandBuilder constructor() {
    return (t) => new ArchiveCommand();
  }
}

class UpdateTodoCommand extends Command<TodoModel> {
  Todo todo;

  UpdateTodoCommand(this.todo);

  @override
  TodoModel exec(TodoModel model) {
    var updated = model.items.singleWhere((t) => t.uid == todo.uid);

    // todo : cascade refacto
    final updatedIndex = model.items.indexOf(updated);
    model.items..removeAt(updatedIndex);
    model.items..insert(updatedIndex, todo);
    return model;
  }

  static CommandBuilder constructor() {
    return (Todo todo) => new UpdateTodoCommand(todo);
  }
}

class ClearArchivesCommand extends Command<TodoModel> {

  @override
  TodoModel exec(TodoModel model) {
    return model..items = model.items.where((t) => !t.completed).toList();
  }

  @override
  static CommandBuilder constructor() {
    return (t) => new ClearArchivesCommand();
  }
}

class ToggleShowArchivesCommand extends Command<TodoModel> {
  @override
  TodoModel exec(TodoModel model) => model..showCompleted = !model.showCompleted;

  static CommandBuilder constructor() {
    return (t) => new ToggleShowArchivesCommand();
  }
}
