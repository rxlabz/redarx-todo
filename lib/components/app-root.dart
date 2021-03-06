import 'dart:async';
import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/component-base.dart';
import 'package:todo_redarx/components/todo-footer.dart';
import 'package:todo_redarx/components/todo-form.dart';
import 'package:todo_redarx/components/todo-list.dart';
import 'package:todo_redarx/components/ui-helper.dart';
import 'package:todo_redarx/mdl/md-card.dart';
import 'package:todo_redarx/model/model.dart';

/**
 * root component
 * displays a todo form , a todo list and a toolbar in a MDL card
 */
class AppComponent<T extends TodoModel> extends ComponentBase {

  TodoForm form;
  TodoList list;
  TodoFooter footer;

  // state$ subscription
  StreamSubscription modelSub;

  Stream<T> _model$;

  set model$(Stream<T> value) {
    print('AppComponent.model value ${value}');
    _model$ = value;
    listen();
  }

  @override
  set dispatch(Dispatch value) {
    super.dispatch = value;
    subComponents.forEach((c) => c.dispatch = value);
  }

  // COnstructor : initialize children
  AppComponent(Element target) : super(target) {
    initView();
  }

  // initialize UI components
  void initView() {
    form = new TodoForm(div(classes:'row',id:'form'));
    children.add(form);

    list = new TodoList();
    children.add(list);

    footer = new TodoFooter(div(classes:'row',id:'footer'));
    children.add(footer);

    MDCard card = new MDCard(
        title: form.render(), content: list.render(), footer: footer.render());
    addChild(card);
  }

  /// dispatch a request to load all todos
  loadAll() => dispatch(new Request(RequestType.LOAD_ALL));

  void listen() {
    if( modelSub != null) modelSub.cancel();

    modelSub = _model$.listen((TodoModel model) {
      list.todos = model.todos;
      footer.numCompleted = model.numCompleted;
      footer.numRemaining = model.numRemaining;
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