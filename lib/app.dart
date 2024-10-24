import 'package:flutter/material.dart';
import 'package:todoapp/features/todo/screens/HomeScreen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
  
    return  MaterialApp(
      navigatorKey:MyApp.navigatorKey ,
      theme: ThemeData(
    primaryColor: Colors.deepPurple, // Set your primary color
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.deepPurple, // Set the background color
      selectedItemColor: Colors.white, // Set the color for selected items
      unselectedItemColor: Colors.grey, // Set the color for unselected items
    ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      );
  }
}