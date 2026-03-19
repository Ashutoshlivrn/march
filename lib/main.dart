import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march/view/homepage.dart';

void main() {
  // Ensure that widget binding is initialized for various plugins
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    // ProviderScope is required to use Riverpod across the app
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}
