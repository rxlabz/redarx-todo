import 'dart:html';

const String CL_SHADOW = "mdl-shadow--2dp";


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



