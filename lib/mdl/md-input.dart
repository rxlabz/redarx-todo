import 'dart:html';

import 'package:todo_redarx/mdl/mdl.dart';

class MDInput extends MDComponent {
  static const String CL_BOX = "mdl-textfield mdl-js-textfield";
  static const String CL_INPUT = 'mdl-textfield__input';
  static const String CL_LBL = 'mdl-textfield__label';
  static const String CL_FLOAT = 'mdl-textfield--floating-label';

  TextInputElement field;
  LabelElement label;

  String placeholder;

  set value(String v) => field.value = v;
  get value => field.value;

  MDInput(String this.placeholder) {
    build();
  }

  MDInput.floating(String this.placeholder) {
    build();
    container.classes.add(CL_FLOAT);
  }

  @override
  void build() {
    field = new InputElement(type: 'text')
      ..id = 'fld'
      ..classes.add(CL_INPUT);
    label = new LabelElement()
      ..htmlFor = 'fld'
      ..classes.add(CL_LBL)
      ..text = placeholder;

    container = new DivElement()
      ..append(field)
      ..append(label)
      ..classes.addAll(csspl(CL_BOX));
  }
}
