import 'package:flutter/material.dart';
import 'app_router.dart';

void main(){
  runApp( App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false, // Set debug banner to false
    );
  }
}