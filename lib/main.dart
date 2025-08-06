import 'package:flutter/material.dart';
import 'package:trade_for_you_app/trade_for_you_app.dart';

import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const TradeForYouApp());
}
