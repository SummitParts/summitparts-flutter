import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:summit_parts/core/app/summit_parts_app.dart';

void runSummitPartsApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLoggy();
  _lockOrientation();

  runApp(const ProviderScope(child: SummitPartsApp()));
}

void _initLoggy() {
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
    logOptions: const LogOptions(kReleaseMode ? LogLevel.off : LogLevel.all),
  );
}

void _lockOrientation() {
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
}
