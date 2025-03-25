



// Build on foundational classes available in flutter.
// It gives the material design components ready to use.
// Flutter does not use native components, so components can be customized for iOS as well
import 'package:flutter/material.dart';
import 'package:flutter_rn_app/screens/dashboard/dashboard.dart';
import 'package:flutter_rn_app/screens/home/home_screen.dart';

// Return type needs to be specified. In case of void, it can be omitted.
void main() {
  runApp(App());  // Need semicolon to specify the end of line.
}

// stateless widget contains a build method, similar to render method in RN.
// Everything in Flutter is a widget.
// StatelessWidget is basically a component which does not have any state of its own.
class App extends StatelessWidget {
  const App({super.key});

  // Build is similar to render method
  // BuildContext is the location of any particular widget in the app.
  @override
  Widget build(BuildContext context) {
    // Only 1 Material App at the root of the project.
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.black),
        brightness: Brightness.dark
      ),
    );
  }
} 
