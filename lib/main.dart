import './screens/products_screen.dart';

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
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'E-Commerce',
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: auth.isAuth ? ProductScreen() : AuthScreen(),
              routes: {}),
        ));
  }
}
