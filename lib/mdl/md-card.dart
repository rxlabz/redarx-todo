import 'dart:html';

import 'package:todo_redarx/components/ui-helper.dart';
import 'package:todo_redarx/mdl/mdl.dart';

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
