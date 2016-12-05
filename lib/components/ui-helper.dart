import 'dart:html';

DivElement div({String classes, String id}) => new DivElement()..classes.addAll(csspl(classes))..id = id;

/**
 * split a css multi-class string tl Iterable
 */
Iterable<String> csspl(String t) => t.split(' ');

Element addClasses(String classes, {Element to}) {
  return to..classes.addAll(classes.split(' '));
}