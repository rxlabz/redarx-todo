import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/component-base.dart';
import 'package:todo_redarx/mdl/md-check.dart';
import 'package:todo_redarx/model/todo.dart';



class TodoList extends ComponentBase {
  List<Todo> _todos;

  UListElement ul;

  set todos(List<Todo> value) {
    if (_todos == value) return;
    _todos = value;
    render();
  }

  @override
  set dispatch(Dispatch value) {
    super.dispatch = value;
    subComponents.forEach((c) => c.dispatch = value);
  }

  TodoList([Element target = null]) : super(target){
    ul = new UListElement();
    this.target.append(ul);
  }

  @override
  render() {
    if (_todos == null) return target;
    ul.children = [];
    final children= _todos
        .where((t) => t != null)
        .map((t) => new TodoItem(id:"chk-${_todos.indexOf(t)}")
      ..todo = t
      ..dispatch = dispatch )
        .map((v) => v.render())
        .toList();
    children.forEach((c)=>ul.append(c) );
    return target;
  }
}

class TodoItem extends ComponentBase {
  DivElement box;

  Todo _todo;

  Todo get todo => _todo;

  set todo(Todo value) {
    _todo = value;

    if (value != null) render();
  }

  MDCheck check;

  TodoItem({Element target = null, String id:''}) : super(target) {
    check = new MDCheck(id:id);
    this.target.append(check.render());
    check.onChange.listen((Event v) => dispatch(new Request(
        RequestType.UPDATE_TODO,
        withData: new Todo(_todo.label,
            check.checked, _todo.uid))));
  }

  @override
  render() {
    check.label = _todo.label;
    check.checked = _todo.completed;
    return target;
  }
}
