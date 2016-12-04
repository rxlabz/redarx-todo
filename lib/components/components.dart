import 'dart:async';
import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todomvc0/commands.dart';
import 'package:todomvc0/components/component-base.dart';
import 'package:todomvc0/components/mdl.dart';
import 'package:todomvc0/model/model.dart';
import 'package:todomvc0/model/todo.dart';

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
  set dispatcher(Dispatcher value) {
    super.dispatcher = value;
    subComponents.forEach((c) => c.dispatcher = value);
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
    dispatcher.dispatch(
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
  set dispatcher(Dispatcher value) {
    super.dispatcher = value;
    subComponents.forEach((i) => (i as ComponentBase).dispatcher = value);
  }

  TodoList([Element target = null]) : super(target){
    ul = new UListElement();
    this.target.append(ul);
  }

  @override
  render() {
    print('TodoList.render... ');
    if (_todos == null) return target;
    ul.children = [];
    final children= _todos
        .where((t) => t != null)
        .map((t) => new TodoItem()
          ..todo = t
          ..dispatcher = dispatcher)
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
    check.onChange.listen((Event v) => dispatcher?.dispatch(new Request(
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
  AnchorElement btArchive;
  AnchorElement btClear;
  AnchorElement btToggle;

  List<Todo> _archives;

  set showCompleted(bool value) =>
      btToggle.text = value ? "Show remaining" : "Show completed";

  set numCompleted(int value) =>
      label.text = "Completed : ${value}";

  createChildren() {
    label = new SpanElement()..text = "Archives :";
    addChild(label);

    btArchive = new AnchorElement(href: '#')
      ..text = "Archive"
      ..onClick
          .listen((e) => dispatcher.dispatch(new Request(RequestType.ARCHIVE)));

    btClear = new AnchorElement(href: '#')
      ..text = "Clear"
      ..onClick.listen(
          (e) => dispatcher.dispatch(new Request(RequestType.CLEAR_ARCHIVES)));

    btToggle = new AnchorElement(href: '#')
      ..text = "Show completed"
      ..onClick.listen((e) =>
          dispatcher.dispatch(new Request(RequestType.TOGGLE_SHOW_COMPLETED)));
    addChildren([label, btArchive, btToggle, btClear]);
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
    ;
  }
}
