import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';

class HtmlWidgetWithUrlLauncher extends StatelessWidget {
  const HtmlWidgetWithUrlLauncher(this.html, {super.key});

  final String html;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(html, factoryBuilder: () => HtmlWidgetWithUrlLauncherFactory());
  }
}

class HtmlWidgetWithUrlLauncherFactory extends WidgetFactory with UrlLauncherFactory {}
