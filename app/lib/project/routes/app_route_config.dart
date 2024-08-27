import 'package:firstapp/pages/Data.dart';
import 'package:firstapp/pages/home.dart';
import 'package:firstapp/pages/metal.dart';
import 'package:firstapp/pages/oil.dart';
import 'package:firstapp/pages/solar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MyAppRouter{

  GoRouter router = GoRouter(

    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state){
          return MaterialPage(child: HomePage());
        }),
      GoRoute(
        path: '/solar',
        name: 'solar',
        pageBuilder: (context, state){
          return MaterialPage(child: SolarPage());
        }),
        GoRoute(
        path: '/oil',
        name: 'oil',
        pageBuilder: (context, state){
          return MaterialPage(child: OilPage());
        }),
        GoRoute(
        path: '/metal',
        name: 'metal',
        pageBuilder: (context, state){
          return MaterialPage(child: MetalPage());
        }),
        GoRoute(
        path: '/data',
        name: 'Rawdata',
        pageBuilder: (context, state){
          return MaterialPage(child: DataPage(page: "Home",));
        })
    ]
  );
}