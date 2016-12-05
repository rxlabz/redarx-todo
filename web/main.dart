import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/components.dart';
import 'package:todo_redarx/model/model.dart';


final actionMap = new Map<RequestType, CommandBuilder>()
  ..[RequestType.ADD_TODO] = AddTodoCommand.constructor()
  ..[RequestType.ARCHIVE] = ArchiveCommand.constructor()
  ..[RequestType.UPDATE_TODO] = UpdateTodoCommand.constructor()
  ..[RequestType.CLEAR_ARCHIVES] = ClearArchivesCommand.constructor()
  ..[RequestType.TOGGLE_SHOW_COMPLETED] = ToggleShowArchivesCommand.constructor();

void main() {

  final cfg = new CommanderConfig<RequestType>(actionMap);

  final store = new Store<TodoModel>(() => new TodoModel.empty());

  var dispatcher = new Dispatcher();
  final cmder = new Commander(cfg, store, dispatcher);
  store.apply();

  var app = new AppComponent(querySelector('#app'), store.data$);
  // todo ? listen to an action stream instead of injecting ?
  app.dispatch = dispatcher.dispatch;
  app.render();
}





