import 'package:flutter/material.dart';
import 'pages/home_page.dart' as pages_home;

/// Lightweight wrapper to expose the refactored HomePage from `lib/pages/home_page.dart`.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const pages_home.HomePage();
}
