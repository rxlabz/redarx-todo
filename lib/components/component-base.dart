import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todo_redarx/mdl/mdl.dart';

typedef Dispatch(Request req);

bool isComponent(el) => el is ComponentBase;

/**
 * Redarx friendly component base
 * - dispatcher
 * - can contains "basic html elements || others ComponentBase"
 */
abstract class ComponentBase {
  /**
   * component root container
   */
  Element target;

  /**
   * component content
   */
  List children;

  /**
   * componentBase children
   */
  List<ComponentBase> get subComponents =>
      children.where((child) => isComponent(child)).toList()
          as List<ComponentBase>;

  /**
   * Request dispatch function
   */
  Dispatch _dispatch;

  Dispatch get dispatch => _dispatch;

  set dispatch(Dispatch value) {
    _dispatch = value;
    injectChildrenDispatch(value);
  }

  /**
   * Abstract component base
   * create a span root container if no target is passed
   */
  ComponentBase([Element this.target = null]) {
    if (target == null) target = new SpanElement();
    children = [];
  }

  /**
   * abstract
   * return component html element
   */
  Element render();

  /**
   * componentBase Dispatcher hierarchical injection
   */
  injectChildrenDispatch(Dispatch dispatch) {
    subComponents.forEach((c) => c.dispatch = dispatch);
  }

  /**
   * add child ( Element, MDComponent, Redarx ComponentBase ) and keep it in the component children list
   */
  void addChild(dynamic el) {
    target
        .append((el is ComponentBase || el is MDComponent) ? el.render() : el);
    children.add(el);
  }

  /**
   * add list of Element
   */
  void addChildren(List<dynamic> els) {
    els.forEach((el) => addChild(el));
  }
}
