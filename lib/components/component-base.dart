import 'dart:html';

import 'package:redarx/redarx.dart';
import 'package:todomvc0/components/mdl.dart';

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
   * injected dispatcher
   */
  Dispatcher _dispatcher;

  Dispatcher get dispatcher => _dispatcher;

  set dispatcher(Dispatcher value) {
    _dispatcher = value;
    injectChildrenDispatcher(value);
  }

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
  injectChildrenDispatcher(Dispatcher dispatcher) {
    subComponents.forEach((c) => dispatcher);
  }

  void addChild(dynamic el) {
    if (el is ComponentBase) {
      target.append((el as ComponentBase).render());
    } else if (el is MDComponent) {
      target.append((el as MDComponent).render());
    } else {
      target.append(el);
    }
    children.add(el);
  }

  void addChildren(List<dynamic> els) {
    els.forEach((el) => addChild(el));
  }

}