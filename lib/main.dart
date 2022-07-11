import 'package:flutter/material.dart';
import 'package:phoenix_cms/login.dart';
import 'utils/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix CMS',
      home: LoginPage(scrollController: _trackingScrollController),
    );
  }
}
