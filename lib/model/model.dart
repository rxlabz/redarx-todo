import 'package:redarx/redarx.dart';
import 'package:todo_redarx/model/todo.dart';

class TodoModel extends AbstractModel {
  List<Todo> items;

  List<Todo> get todos =>
      items.where((t) => showCompleted ? t.completed : !t.completed).toList();

  int get numCompleted => items.where((t)=>t.completed).length;

  int get numRemaining => items.where((t)=>!t.completed).length;

  bool showCompleted;

  TodoModel.empty() {
    showCompleted = false;
    items = [];
  }

  @override
  AbstractModel initial() => new TodoModel.empty();

  @override
  String toString() {
    return '''
Model{
  showCompleted = $showCompleted,
  todos : $todos
}
''';
  }
}
