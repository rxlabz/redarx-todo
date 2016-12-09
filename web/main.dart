import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/app-root.dart';
import 'package:todo_redarx/mdl/md-button.dart';
import 'package:todo_redarx/model/model.dart';

final requestMap = new Map<RequestType, CommandBuilder>()
  ..[RequestType.ADD_TODO] = AddTodoCommand.constructor()
  ..[RequestType.ARCHIVE] = ArchiveCommand.constructor()
  ..[RequestType.UPDATE_TODO] = UpdateTodoCommand.constructor()
  ..[RequestType.CLEAR_ARCHIVES] = ClearArchivesCommand.constructor()
  ..[RequestType.TOGGLE_SHOW_COMPLETED] =
      ToggleShowArchivesCommand.constructor();

void main() {
  final cfg = new CommanderConfig<RequestType>(requestMap);
  final store = new ReversibleStore<Command<TodoModel>,
      TodoModel>(() => new TodoModel.empty());
  final dispatcher = new Dispatcher();

  final cmder = new Commander<Command<TodoModel>, TodoModel>(
      cfg, store, dispatcher.onRequest);

  var app = new AppComponent<TodoModel>(querySelector('#app'))
    ..model$ = store.state$
    ..dispatch = dispatcher.dispatch
    ..render();

  document.body.append(
      MDButton.raised('Cancel', onClick: (e) => store.cancel()));
}
