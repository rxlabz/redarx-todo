import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/commands.dart';
import 'package:todo_redarx/components/component-base.dart';
import 'package:todo_redarx/components/ui-helper.dart';

class TodoFooter extends ComponentBase {
  SpanElement label;
  AnchorElement btClear;
  AnchorElement btToggle;

  set showCompleted(bool value) {
    btToggle.text =
        value ? "Remaining ( $_numRemaining )" : "Completed ( $_numCompleted )";
    label.text =
        value ? "Completed : ${_numCompleted}" : "Remaining : ${_numRemaining}";
  }

  int _numCompleted;
  set numCompleted(int value) => _numCompleted = value;

  int _numRemaining;
  set numRemaining(int value) => _numRemaining = value;

  createChildren() {
    label = new SpanElement()..text = "Archives :";
    addChild(label);

    btClear = a(
        href: '#',
        label: "Clear",
        onClick: (e) => dispatch(new Request(RequestType.CLEAR_ARCHIVES)));

    btToggle = a(
        href: '#',
        label: "Show completed",
        onClick: (e) =>
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
