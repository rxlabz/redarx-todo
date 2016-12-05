import 'dart:html';

const String CL_SHADOW = "mdl-shadow--2dp";

/**
 * split a css multi-class string tl Iterable
 */
Iterable<String> csspl(String t) => t.split(' ');

Element addClasses(String classes, {Element to}) {
  return to..classes.addAll(classes.split(' '));
}

/**
 * instantiate a <i> icon
 */
getIcon(String type) => new Element.tag('i')
  ..classes.add("material-icons")
  ..text = type;

/**
 * mdComponent base
 */
abstract class MDComponent {
  Element container;

  Element render() {
    return container;
  }

  void build();
}



