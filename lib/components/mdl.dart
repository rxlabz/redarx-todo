import 'dart:async';
import 'dart:html';
import 'dart:math';

const BT_RAISED = "mdl-button mdl-js-button mdl-button--raised";

const BT_RAISED_ACCENT =
    "mdl-button mdl-js-button mdl-button--raised mdl-button--accent";

const FAB_COLOR =
    "mdl-button mdl-js-button mdl-button--fab mdl-button--colored";

const MINI_FAB_COLOR =
    "mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored";

Iterable<String> csspl(String t) => t.split(' ');

Element addClasses(String classes, {Element to}) {
  return to..classes.addAll(classes.split(' '));
}

abstract class MDComponent {
  Element container;

  Element render() {
    return container;
  }

  void build();
}

const String CL_SHADOW = "mdl-shadow--2dp";

class MDCard extends MDComponent {
  static const String CL_CARD = "mdl-card mdl-shadow--2dp";
  static const String CL_CARD_CONTENT = "mdl-card__supporting-text";
  static const String CL_TITLE = "mdl-card__title";
  static const String CL_FOOTER = "mdl-card__actions mdl-card--border";

  int width;
  int height;

  DivElement titleBox;
  DivElement contentBox;
  DivElement footerBox;

  MDCard(
      {Element title: null,
      content: null,
      footer: null,
      this.width: 500,
      this.height: null}) {
    build();

    if (title != null) addToTitle(title);
    if (content != null) addToContent(content);
    if (footer != null) addToFooter(footer);
  }

  void build() {
    container = new DivElement()
      ..classes.addAll(csspl(CL_CARD))
      ..style.width = "${width}px";
    titleBox = new DivElement()..classes.addAll(csspl(CL_TITLE));
    contentBox = new DivElement()..classes.add(CL_CARD_CONTENT);
    footerBox = new DivElement()..classes.addAll(csspl(CL_FOOTER));
    container.append(titleBox);
    container.append(contentBox);
    container.append(footerBox);
  }

  void addToTitle(Element el) {
    titleBox.append(el);
  }

  void addToContent(Element el) {
    contentBox.append(el);
  }

  void addToFooter(Element el) {
    footerBox.append(el);
  }

  render() {
    return container;
  }
}

class MDButton {
  static ButtonElement base({String id: null, String mdClasses: BT_RAISED}) =>
      new ButtonElement()
        ..id = id
        ..classes.addAll(csspl(mdClasses));

  static ButtonElement raised(String label, {onClick: null, id: null}) =>
      base(id: id, mdClasses: BT_RAISED)
        ..text = label
        ..onClick.listen((e) => onClick(e));

  static ButtonElement raisedAccent(String label, {onClick: null, id: null}) =>
      base(id: id, mdClasses: BT_RAISED)
        ..text = label
        ..onClick.listen((e) => onClick(e));

  static ButtonElement fab(
          {onClick: null, id: null, String icon: 'check', bool mini: false}) =>
      base(mdClasses: mini ? MINI_FAB_COLOR : FAB_COLOR)
        ..id = id
        ..onClick.listen((e) => onClick(e))
        ..append(getIcon(icon));
}

getIcon(String type) => new Element.tag('i')
  ..classes.add("material-icons")
  ..text = type;

class MDCheck extends MDComponent {
  static const String CL_CHECK =
      "mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect";
  static const String CL_CHECK_INPUT = "mdl-checkbox__input";

  static const String CL_CHECK_LABEL = "mdl-checkbox__label";

  CheckboxInputElement input;
  SpanElement labelView;
  //LabelElement container;

  set label(String value) => labelView.text = value;
  set checked(bool value) => input.checked = value;
  bool get checked => input.checked ;

  get onChange => input.onChange;

  MDCheck() {
    build();
  }

  @override
  void build() {
    final tId = 'chk-${rand()}';
    input = new CheckboxInputElement()..id = tId..classes.add(CL_CHECK_INPUT);
    labelView = new SpanElement()..classes.addAll(csspl(CL_CHECK_LABEL));
    container = new LabelElement()
      ..htmlFor = tId
      ..classes.addAll(csspl(CL_CHECK))
      ..append(input)
      ..append(labelView);
  }
}

int rand()=>new Random().nextInt(999999);

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

  MDInput.floating(String placeholder) {
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

  /*static DivElement basic(String placeholder) {
    final input = new InputElement(type: 'text')
      ..id = 'fld'
      ..classes.add(CL_INPUT);
    final lbl = new LabelElement()
      ..htmlFor = 'fld'
      ..classes.add(CL_LBL)
      ..text = placeholder;

    return new DivElement()
      ..append(input)
      ..append(lbl)
      ..classes.addAll(csspl(CL_BOX));
  }*/
}
