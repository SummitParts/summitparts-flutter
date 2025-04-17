import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/home_navigation/model/feature_tab.dart';

final currentScreenProvider = StateProvider.autoDispose<FeatureTab>((ref) => FeatureTab.dashboard);
