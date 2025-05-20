import 'package:flutter/widgets.dart';

extension WidgetIterableExtension on Iterable<Widget> {
  List<Widget> joinWith(Widget separator) {
    return expand((widget) sync* {
      yield widget;
      yield separator;
    }).toList()..removeLast();
  }
}
