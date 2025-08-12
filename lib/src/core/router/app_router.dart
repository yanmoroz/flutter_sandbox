import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/todo/navigation/todo_routes.dart';

final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: TodoRoutes.home,
    routes: <RouteBase>[...TodoRoutes.routes()],
    observers: [_SimpleRouteObserver()],
    restorationScopeId: 'app',
  );
}

class _SimpleRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('➡️ push: ${route.settings.name ?? route.settings}');
  }
}
