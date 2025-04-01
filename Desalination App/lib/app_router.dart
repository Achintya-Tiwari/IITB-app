import 'package:go_router/go_router.dart';
import 'bottombar.dart';
import 'Data.dart';
import 'home.dart';
import 'Solar.dart';

GoRouter appRouter =GoRouter(routes: [
  StatefulShellRoute.indexedStack(
    builder: (context,state,shell) => Bottombar(shell: shell),
    branches: [
    StatefulShellBranch(routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => HomePage(),)
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: "/solar",
        builder: (context, state) => GraphPage(),)
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: "/data",
        builder: (context, state) => DataPage(),)
    ]),
  ])
]);