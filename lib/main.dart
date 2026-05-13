import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/app_theme.dart';
import 'viewmodels/news_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/// التطبيق الرئيسي - TechPost
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// توفير NewsViewModel للتطبيق كله باستخدام Provider
        ChangeNotifierProvider(
          create: (_) => NewsViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'TechPost',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
