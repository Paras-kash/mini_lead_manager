import 'package:flutter/material.dart';
import 'package:mini_lead_manager/providers/leads_provider.dart';
import 'package:mini_lead_manager/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeadsProvider()..init(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            background: Colors.white30,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
