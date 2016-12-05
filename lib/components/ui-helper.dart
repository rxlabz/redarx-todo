import 'dart:html';

DivElement div({String classes, String id}) => new DivElement()
  ..classes.addAll(csspl(classes))
  ..id = id;

AnchorElement a({href: "#", String label, onClick}) =>
    new AnchorElement(href: href)
      ..text = label
      ..onClick.listen((e) => onClick(e));

/**
 * split a css multi-class string tl Iterable
 */
Iterable<String> csspl(String t) => t.split(' ');

Element addClasses(String classes, {Element to}) {
  return to..classes.addAll(classes.split(' '));
}
