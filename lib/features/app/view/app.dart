import 'package:flutter/material.dart';

import 'package:flutter_grocery/features/home/home.dart';
import 'package:flutter_grocery/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.instance.theme,
      home: const HomePage(),
    );
  }
}
