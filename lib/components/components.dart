import 'dart:async';
import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/component-base.dart';
import 'package:todo_redarx/mdl/mdl.dart';
import 'package:todo_redarx/model/model.dart';
import 'package:todo_redarx/model/todo.dart';

/**
 * root component
 * displays a todo form , a todo list and a toolbar in a MDL card
 */
class AppComponent extends ComponentBase {
  TodoForm form;

  TodoList list;

  TodoFooter footer;

  List<Todo> archivedTodos = [];

  Stream<TodoModel> model$;

  @override
  set dispatch(Dispatch value) {
    super.dispatch = value;
    subComponents.forEach((c) => c.dispatch = value);
  }

  AppComponent(Element target, Stream<TodoModel> this.model$) : super(target) {
    listenModelStream();

    initView();
  }

  void initView() {
    form = new TodoForm(new DivElement());
    children.add(form);

    list = new TodoList();
    children.add(list);

    footer = new TodoFooter(new DivElement()..classes.add('row'));
    children.add(footer);

    MDCard card = new MDCard(
        title: form.render(), content: list.render(), footer: footer.render());
    addChild(card);
  }

  void listenModelStream() {
    model$.listen((TodoModel model) {
      print('AppComponent.AppComponent  onModel ${model}');
      list.todos = model.todos;
      footer.numCompleted = model.numCompleted;
      footer.showCompleted = model.showCompleted;
    });
  }

  @override
  render() {
    form.render();
    list.render();
    footer.render();
  }
}

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
        .map((t) => new TodoItem()
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

  TodoItem([Element target = null]) : super(target) {
    check = new MDCheck();
    this.target.append(check.render());
    check.onChange.listen((Event v) => dispatch(new Request(
        RequestType.UPDATE_TODO,
        withValue: new Todo(_todo.label,
            check.checked, _todo.uid))));
  }

  @override
  render() {
    check.label = _todo.label;
    check.checked = _todo.completed;
    return target;
  }
}

class TodoFooter extends ComponentBase {

  SpanElement label;
  AnchorElement btClear;
  AnchorElement btToggle;

  set showCompleted(bool value) =>
      btToggle.text = value ? "Show remaining" : "Show completed";

  set numCompleted(int value) =>
      label.text = "Completed : ${value}";

  createChildren() {
    label = new SpanElement()..text = "Archives :";
    addChild(label);

    btClear = new AnchorElement(href: '#')
      ..text = "Clear"
      ..onClick.listen(
          (e) => dispatch(new Request(RequestType.CLEAR_ARCHIVES)));

    btToggle = new AnchorElement(href: '#')
      ..text = "Show completed"
      ..onClick.listen((e) =>
          dispatch(new Request(RequestType.TOGGLE_SHOW_COMPLETED)));
    addChildren([label, btToggle, btClear]);
  }

  TodoFooter([Element target = null]) : super(target) {
    createChildren();
  }

  @override
  Element render() {
    return target
      ..children = children
          .map((el) =>
              isComponent(el) ? (el as ComponentBase).render() : el as Element)
          .toList();
  }
}
