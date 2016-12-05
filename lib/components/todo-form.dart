import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/component-base.dart';
import 'package:todo_redarx/mdl/md-button.dart';
import 'package:todo_redarx/mdl/md-input.dart';
import 'package:todo_redarx/model/todo.dart';

class TodoForm extends ComponentBase {
  MDInput fldTodo;

  ButtonElement btAdd;

  TodoForm([Element target = null]) : super(target) {
    fldTodo = new MDInput.floating('Todo...');
    btAdd =
        MDButton.fab(id: 'btAdd', icon: "add", mini: true, onClick: onSubmit);
  }

  void onSubmit(e) {
    if (fldTodo.value == '') return;
    dispatch(
        new Request(RequestType.ADD_TODO, withValue: new Todo(fldTodo.value)));
    fldTodo.value = '';
  }

  @override
  Element render() {
    var children = [
      fldTodo.render(),
      btAdd,
    ];
    target.children = children;
    return target;
  }
}

