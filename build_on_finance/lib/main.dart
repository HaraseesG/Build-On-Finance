import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const BuildOnFinanceApp());
}

class BuildOnFinanceApp extends StatelessWidget {
  const BuildOnFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Build On Finance',
      theme: AppTheme.theme,
      home: const _PlaceholderHomeScreen(),
    );
  }
}

/// Stands in for the real navigation shell until it lands (Epic 3.2, #51).
class _PlaceholderHomeScreen extends StatelessWidget {
  const _PlaceholderHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Build On Finance',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
