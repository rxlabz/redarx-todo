import 'dart:html';

import 'package:todo_redarx/components/ui-helper.dart';
import 'package:todo_redarx/mdl/mdl.dart';

const BT_RAISED = "mdl-button mdl-js-button mdl-button--raised";

const BT_RAISED_ACCENT =
    "mdl-button mdl-js-button mdl-button--raised mdl-button--accent";

const FAB_COLOR =
    "mdl-button mdl-js-button mdl-button--fab mdl-button--colored";

const MINI_FAB_COLOR =
    "mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored";

class MDButton {

  static ButtonElement _base({String id: null, String mdClasses: BT_RAISED}) =>
      new ButtonElement()
        ..id = id
        ..classes.addAll(csspl(mdClasses));

  static ButtonElement raised(String label, {onClick: null, id: null}) =>
      _base(id: id, mdClasses: BT_RAISED)
        ..text = label
        ..onClick.listen((e) => onClick(e));

  static ButtonElement raisedAccent(String label, {onClick: null, id: null}) =>
      _base(id: id, mdClasses: BT_RAISED)
        ..text = label
        ..onClick.listen((e) => onClick(e));

  static ButtonElement fab(
      {onClick: null, id: null, String icon: 'check', bool mini: false}) =>
      _base(mdClasses: mini ? MINI_FAB_COLOR : FAB_COLOR)
        ..id = id
        ..onClick.listen((e) => onClick(e))
        ..append(getIcon(icon));
}