import 'dart:html';

import 'package:todo_redarx/mdl/mdl.dart';

class MDCheck extends MDComponent {
  static const String CL_CHECK =
      "mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect";
  static const String CL_CHECK_INPUT = "mdl-checkbox__input";

  static const String CL_CHECK_LABEL = "mdl-checkbox__label";

  CheckboxInputElement input;
  SpanElement labelView;

  String id;

  set label(String value) => labelView.text = value;
  set checked(bool value) => input.checked = value;
  bool get checked => input.checked ;

  get onChange => input.onChange;

  MDCheck({String this.id}) {
    build();
  }

  @override
  void build() {
    final tId = id;
    input = new CheckboxInputElement()..id = tId..classes.add(CL_CHECK_INPUT);
    labelView = new SpanElement()..classes.addAll(csspl(CL_CHECK_LABEL));
    container = new LabelElement()
      ..htmlFor = tId
      ..classes.addAll(csspl(CL_CHECK))
      ..append(input)
      ..append(labelView);
  }
}
