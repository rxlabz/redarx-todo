import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/app-root.dart';
import 'package:todo_redarx/model/model.dart';

const DATA_PATH = "todos.json";

/// RequestType » Command mapping
final requestMap = new Map<RequestType, CommandBuilder>()
  ..[RequestType.LOAD_ALL] = AsyncLoadAllCommand.constructor(DATA_PATH)
  ..[RequestType.ADD_TODO] = AddTodoCommand.constructor()
  ..[RequestType.UPDATE_TODO] = UpdateTodoCommand.constructor()
  ..[RequestType.CLEAR_ARCHIVES] = ClearArchivesCommand.constructor()
  ..[RequestType.COMPLETE_ALL] = CompleteAllCommand.constructor()
  ..[RequestType.TOGGLE_SHOW_COMPLETED] =
      ToggleShowArchivesCommand.constructor();

void main() {

  final cfg = new CommanderConfig<RequestType>(requestMap);
  final store = new Store<Command<TodoModel>,
      TodoModel>(() => new TodoModel.empty());
  final dispatcher = new Dispatcher();

  final cmder = new Commander<Command<TodoModel>, TodoModel>(
      cfg, store, dispatcher.onRequest);

  var app = new AppComponent<TodoModel>(querySelector('#app'))
    ..dispatch = dispatcher.dispatch
    ..model$ = store.state$
    ..loadAll()
    ..render();
}
