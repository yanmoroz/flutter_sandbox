import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injector.dart';
import '../presentation/bloc/todo_bloc.dart';
import '../presentation/bloc/todo_bloc_factory.dart';
import '../presentation/pages/todo_page.dart';

final class TodoRoutes {
  static const String home = '/';
  static const String detail = '/todo/:id';

  static List<RouteBase> routes() => <RouteBase>[_home()];

  static GoRoute _home() => GoRoute(path: home, pageBuilder: _todoHomePage);

  static Page<dynamic> _todoHomePage(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      key: state.pageKey,
      child: BlocProvider<TodoBloc>(
        create: (_) {
          final bloc = sl<TodoBlocFactory>().create();
          bloc.add(const LoadTodos());
          return bloc;
        },
        child: const TodoPage(),
      ),
    );
  }
}
