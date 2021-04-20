import './screens/auth_screen.dart';
import './widgets/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
          title: 'E-Commerce',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: AuthScreen(),
          routes: {}),
    );
  }
}
