import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todomvc0/commands.dart';
import 'package:todomvc0/components/components.dart';
import 'package:todomvc0/model/model.dart';

void main() {
  final actionMap = new Map<RequestType, CommandBuilder>()
    ..[RequestType.ADD_TODO] = AddTodoCommand.constructor()
    ..[RequestType.ARCHIVE] = ArchiveCommand.constructor()
    ..[RequestType.UPDATE_TODO] = UpdateTodoCommand.constructor()
    ..[RequestType.CLEAR_ARCHIVES] = ClearArchivesCommand.constructor()
    ..[RequestType.TOGGLE_SHOW_COMPLETED] = ToggleShowArchivesCommand.constructor();

  final cfg = new CommanderConfig<RequestType>(actionMap);

  final store = new Store<TodoModel>(() => new TodoModel.empty());

  var dispatcher = new Dispatcher();
  final cmder = new Commander(cfg, store, dispatcher);
  store.apply();

  var app = new AppComponent(querySelector('#app'), store.data$);
  // todo ? listen to an action stream instead of injecting ?
  app.dispatcher = dispatcher;
  app.render();
}





